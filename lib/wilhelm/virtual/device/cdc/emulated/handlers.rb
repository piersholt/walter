# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module CDC
        class Emulated < Device::Emulated
          # Incoming command handlers
          module Handlers
            include Capabilities::CDChanger::Constants
            include Messaging::API
            include Messaging::Constants
            include LogActually::ErrorOutput

            def handle_cd_changer_request(command)
              LOGGER.debug(ident) { "State prior to handling: #{mapped}" }
              delegate_changer_request(command)
              LOGGER.debug(ident) { 'Finishing up. Sending status...' }
              send_status(current_state)
            end

            def delegate_changer_request(command)
              LOGGER.debug(name) { "#delegate_changer_request(control: #{command.control?}, mode: #{command.mode?})" }
              case command.control?
              when :status
                LOGGER.debug(name) { "=> :status!" }
                handle_status_request
              when :resume
                LOGGER.debug(name) { "=> :resume!" }
                handle_play
                play!
              when :play
                LOGGER.debug(name) { "=> :play!" }
                handle_play
                play!
              when :stop
                LOGGER.debug(name) { "=> :stop!" }
                handle_stop
                stop!
              when :seek
                LOGGER.debug(name) { "=> :seek!" }
                handle_seek(request_mode: command.mode.value)
                play!
              when :scan
                LOGGER.debug(name) { "=> :scan!" }
                handle_scan(request_mode: command.mode.value)
              when :change_disc
                LOGGER.debug(name) { "=> :change_disc!" }
                handle_change_disc(request_mode: command.mode.value)
              when :change_track
                LOGGER.debug(name) { "=> :change_track!" }
                handle_change_track(request_mode: command)
                play!
              else
                LOGGER.warn(name) { "Control: #{control}, not handled?" }
                return false
              end
            rescue StandardError => e
              with_backtrace(LOGGER, e)
            end

            # Radio Request Handling

            def handle_status_request
              LOGGER.debug(ident) { 'Handling CDC status. (Sending current state.)' }
              case control?
              when :next
                playing.active
              when :previous
                playing.active
              end
            end

            def handle_stop
              LOGGER.debug(ident) { 'Handling disc stop.' }

              stopped
              LOGGER.debug(ident) { "Stopped => #{mapped}" }
              idle
              LOGGER.debug(ident) { "Idle => #{mapped}" }
            end

            def stop!
              LOGGER.debug(ident) { 'Notification: stop!' }
              thy_will_be_done!(MEDIA, STOP)
            rescue StandardError => e
              with_backtrace(LOGGER, e)
            end

            def play!
              LOGGER.debug(ident) { 'Notification: play!' }
              thy_will_be_done!(MEDIA, PLAY)
            rescue StandardError => e
              with_backtrace(LOGGER, e)
            end

            def handle_play
              LOGGER.debug(ident) { 'Handling disc play.' }
              playing
              LOGGER.debug(ident) { "Playing => #{mapped}" }
              active
              LOGGER.debug(ident) { "Active => #{mapped}" }
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
                LOGGER.debug(ident) { "CD & Track => #{mapped}" }
              when CONTROL[:playing_new]
                cd(current_cd)
                track(current_track)
                LOGGER.debug(ident) { "CD & Track => #{mapped}" }
              else
                LOGGER.warn(ident) { 'handle play current control not handled?' }
                state!(cd: 9, track: 99)
              end
            end

            def handle_seek(request_mode:)
              LOGGER.debug(ident) { "#handle_seek(#{mode})" }

              case request_mode
              when 0
                LOGGER.debug(ident) { "mode 0 => next_track" }
                control_next
                LOGGER.debug(ident) { "Next => #{mapped}" }
                track(next_track)
                LOGGER.debug(ident) { "Track => #{mapped}" }
              when 1
                LOGGER.debug(ident) { "mode 1 => previous_track" }
                previous
                LOGGER.debug(ident) { "Previous => #{mapped}" }
                track(previous_track)
                LOGGER.debug(ident) { "Track => #{mapped}" }
              else
                LOGGER.warn(ident) { "mode #{mode} => ???" }
              end

              idle
              # start_timer
            end

            # You must acknowledge change disc, and cannot skip directly to playing
            # with updated track number.
            def handle_change_track(request_mode:)
              LOGGER.debug(ident) { "#handle_change_track(#{request_mode.mode?})" }

              case request_mode.mode?
              when :forward
                LOGGER.debug(ident) { "Mode => :forward" }
                LOGGER.debug(ident) { 'Set control to next track.' }
                control_next
                LOGGER.debug(ident) { 'Increment track.' }
                track_next
              when :backward
                LOGGER.debug(ident) { "Mode => :backward" }
                LOGGER.debug(ident) { 'Set control to previous track.' }
                control_previous
                LOGGER.debug(ident) { 'Decrease track.' }
                track_previous
              else
                LOGGER.warn(ident) { "mode #{mode} => ???" }
              end

              # LOGGER.debug(ident) { "Track => #{mapped}" }

              idle.done
              # start_timer
              Kernel.sleep(0.05)
              playing.active
            end

            def handle_scan(request_mode:)
              LOGGER.debug(ident) { 'Handling track scan.' }

              case request_mode
              when 0
                LOGGER.debug(ident) { "mode 0 => fwd" }
                fwd
                LOGGER.debug(ident) { "FWD => #{mapped}" }
              when 1
                LOGGER.debug(ident) { "mode 0 => rwd" }
                rwd
                LOGGER.debug(ident) { "RWD => #{mapped}" }
              end

              idle
              # start_timer
            end

            def handle_change_disc(request_mode:)
              LOGGER.debug(ident) { 'Handling disc change.' }

              requested_disc = request_mode
              LOGGER.debug(ident) { "Requested disc: #{requested_disc}" }

              stopped
              active
              cd(1)
              track(1)
            end
          end
        end
      end
    end
  end
end
