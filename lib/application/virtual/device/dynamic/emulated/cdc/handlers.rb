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
        send_status(current_state)
      end

      def delegate_changer_request(command)
        LogActually.cdc.debug(name) { "Control: #{command.control?}, Mode: #{command.mode.value}" }
        case command.control?
        when :status
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :status!" }
          handle_status_request
        when :resume
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :resume!" }
          handle_play
          play!
        when :play
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :play!" }
          handle_play
          play!
        when :stop
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :stop!" }
          handle_stop
          stop!
        when :seek
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :seek!" }
          handle_seek(request_mode: command.mode.value)
          play!
        when :scan
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :scan!" }
          handle_scan(request_mode: command.mode.value)
        when :change_disc
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :change_disc!" }
          handle_change_disc(request_mode: command.mode.value)
          send_status(current_state)
          handle_play
        when :change_track
          LogActually.cdc.debug(name) { "Mode: #{command.mode.value} => :change_track!" }
          handle_seek(request_mode: command.mode.value)
        else
          LogActually.cdc.warn(name) { "Control: #{control}, not handled?" }
          return false
        end
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      # Radio Request Handling

      def handle_status_request
        LogActually.cdc.info(ident) { 'Handling CDC status.' }
      end

      def handle_stop
        LogActually.cdc.info(ident) { 'Handling disc stop.' }

        stopped
        LogActually.cdc.debug(ident) { "Stopped => #{mapped}" }
        idle
        LogActually.cdc.debug(ident) { "Idle => #{mapped}" }
      end

      def stop!
        LogActually.cdc.info(ident) { 'Notification: stop!' }
        thy_will_be_done!(MEDIA, STOP)
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      def play!
        LogActually.cdc.info(ident) { 'Notification: play!' }
        thy_will_be_done!(MEDIA, PLAY)
      rescue StandardError => e
        with_backtrace(LogActually.cdc, e)
      end

      def handle_play
        LogActually.cdc.info(ident) { 'Handling disc play.' }
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
        else
          LogActually.cdc.warn(ident) { 'handle play current control not handled?' }
          state!(cd: 9, track: 99)
        end
      end

      def handle_seek(request_mode:)
        LogActually.cdc.info(ident) { "#handle_seek(#{mode})" }

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

      def handle_scan(request_mode:)
        LogActually.cdc.info(ident) { 'Handling track scan.' }

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
        LogActually.cdc.info(ident) { 'Handling disc change.' }

        requested_disc = request_mode
        LogActually.cdc.debug(ident) { "Requested disc: #{requested_disc}" }

        ready
        active
        cd(requested_disc)
        track(1)

        # new_state = { control: CONTROL[:changed],
        #               status: STATUS[:active],
        #               cd: requested_disc,
        #               track: 1 }
        # state!(new_state)
      end
    end
  end
end
