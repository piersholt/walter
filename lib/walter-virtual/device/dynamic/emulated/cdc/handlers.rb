# frozen_string_literal: true

class Virtual
  class EmulatedCDC < EmulatedDevice
    # Incoming command handlers
    module Handlers
      include Capabilities::CDChanger::Constants
      include Messaging::API
      include Messaging::Constants
      include LogActually::ErrorOutput

      def handle_cd_changer_request(command)
        LogActually.cdc.debug(ident) { "State prior to handling: #{mapped}" }
        delegate_changer_request(command)
        LogActually.cdc.debug(ident) { 'Finishing up. Sending status...' }
        send_status(current_state)
      end

      def delegate_changer_request(command)
        LogActually.cdc.debug(name) { "#delegate_changer_request(control: #{command.control?}, mode: #{command.mode?})" }
        case command.control?
        when :status
          LogActually.cdc.debug(name) { "=> :status!" }
          handle_status_request
        when :resume
          LogActually.cdc.debug(name) { "=> :resume!" }
          handle_play
          play!
        when :play
          LogActually.cdc.debug(name) { "=> :play!" }
          handle_play
          play!
        when :stop
          LogActually.cdc.debug(name) { "=> :stop!" }
          handle_stop
          stop!
        when :seek
          LogActually.cdc.debug(name) { "=> :seek!" }
          handle_seek(request_mode: command.mode.value)
          play!
        when :scan
          LogActually.cdc.debug(name) { "=> :scan!" }
          handle_scan(request_mode: command.mode.value)
        when :change_disc
          LogActually.cdc.debug(name) { "=> :change_disc!" }
          handle_change_disc(request_mode: command.mode.value)
        when :change_track
          LogActually.cdc.debug(name) { "=> :change_track!" }
          handle_change_track(request_mode: command)
          play!
        else
          LogActually.cdc.warn(name) { "Control: #{control}, not handled?" }
          return false
        end
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      # Radio Request Handling

      def handle_status_request
        LogActually.cdc.debug(ident) { 'Handling CDC status. (Sending current state.)' }
        case control?
        when :next
          playing.active
        when :previous
          playing.active
        end
      end

      def handle_stop
        LogActually.cdc.debug(ident) { 'Handling disc stop.' }

        stopped
        LogActually.cdc.debug(ident) { "Stopped => #{mapped}" }
        idle
        LogActually.cdc.debug(ident) { "Idle => #{mapped}" }
      end

      def stop!
        LogActually.cdc.debug(ident) { 'Notification: stop!' }
        thy_will_be_done!(MEDIA, STOP)
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      def play!
        LogActually.cdc.debug(ident) { 'Notification: play!' }
        thy_will_be_done!(MEDIA, PLAY)
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      def handle_play
        LogActually.cdc.debug(ident) { 'Handling disc play.' }
        playing
        LogActually.cdc.debug(ident) { "Playing => #{mapped}" }
        active
        LogActually.cdc.debug(ident) { "Active => #{mapped}" }
        case current_control
        when CONTROL[:fwd]
          track(next_track) if too_short_to_be_scan?
        when CONTROL[:rwd]
          track(previous_track)  if too_short_to_be_scan?
        when CONTROL[:off]
          state!(cd: 0, track: 0)
        when CONTROL[:playing]
          cd(current_cd)
          track(current_track)
          LogActually.cdc.debug(ident) { "CD & Track => #{mapped}" }
        when CONTROL[:playing_new]
          cd(current_cd)
          track(current_track)
          LogActually.cdc.debug(ident) { "CD & Track => #{mapped}" }
        else
          LogActually.cdc.warn(ident) { 'handle play current control not handled?' }
          state!(cd: 9, track: 99)
        end
      end

      def handle_seek(request_mode:)
        LogActually.cdc.debug(ident) { "#handle_seek(#{mode})" }

        case request_mode
        when 0
          LogActually.cdc.debug(ident) { "mode 0 => next_track" }
          control_next
          LogActually.cdc.debug(ident) { "Next => #{mapped}" }
          track(next_track)
          LogActually.cdc.debug(ident) { "Track => #{mapped}" }
        when 1
          LogActually.cdc.debug(ident) { "mode 1 => previous_track" }
          previous
          LogActually.cdc.debug(ident) { "Previous => #{mapped}" }
          track(previous_track)
          LogActually.cdc.debug(ident) { "Track => #{mapped}" }
        else
          LogActually.cdc.warn(ident) { "mode #{mode} => ???" }
        end

        idle
        # start_timer
      end

      # You must acknowledge change disc, and cannot skip directly to playing
      # with updated track number.
      def handle_change_track(request_mode:)
        LogActually.cdc.debug(ident) { "#handle_change_track(#{request_mode.mode?})" }

        case request_mode.mode?
        when :forward
          LogActually.cdc.debug(ident) { "Mode => :forward" }
          LogActually.cdc.debug(ident) { 'Set control to next track.' }
          control_next
          LogActually.cdc.debug(ident) { 'Increment track.' }
          track_next
        when :backward
          LogActually.cdc.debug(ident) { "Mode => :backward" }
          LogActually.cdc.debug(ident) { 'Set control to previous track.' }
          control_previous
          LogActually.cdc.debug(ident) { 'Decrease track.' }
          track_previous
        else
          LogActually.cdc.warn(ident) { "mode #{mode} => ???" }
        end

        # LogActually.cdc.debug(ident) { "Track => #{mapped}" }

        idle.done
        # start_timer
        Kernel.sleep(0.05)
        playing.active
      end

      def handle_scan(request_mode:)
        LogActually.cdc.debug(ident) { 'Handling track scan.' }

        case request_mode
        when 0
          LogActually.cdc.debug(ident) { "mode 0 => fwd" }
          fwd
          LogActually.cdc.debug(ident) { "FWD => #{mapped}" }
        when 1
          LogActually.cdc.debug(ident) { "mode 0 => rwd" }
          rwd
          LogActually.cdc.debug(ident) { "RWD => #{mapped}" }
        end

        idle
        # start_timer
      end

      def handle_change_disc(request_mode:)
        LogActually.cdc.debug(ident) { 'Handling disc change.' }

        requested_disc = request_mode
        LogActually.cdc.debug(ident) { "Requested disc: #{requested_disc}" }

        stopped
        active
        cd(1)
        track(1)
      end
    end
  end
end
