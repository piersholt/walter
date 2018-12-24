# frozen_string_literal: true

class Virtual
  class EmulatedCDC < EmulatedDevice
    # Incoming command handlers
    module Handlers
      def handle_cd_changer_request(command)
        delegate_changer_request(command)
        # send_status(current_state)
      end

      def delegate_changer_request(command)
        LogActually.cdc.debug(name) { "#{command.control?}, #{command.mode.value}" }
        case command.control?
        when :status
          LogActually.cdc.debug(name) { ':status!' }
          # handle_status_request
        when :play
          LogActually.cdc.debug(name) { ':play!' }
          # handle_play
        when :stopped
          LogActually.cdc.debug(name) { ':stopped!' }
          # handle_stop
        when :seek
          LogActually.cdc.debug(name) { ':seek!' }
          # handle_seek(request_mode: command.mode.value)
        when :scan
          LogActually.cdc.debug(name) { ':scan!' }
          # handle_scan(request_mode: command.mode.value)
        when :change_disc
          LogActually.cdc.debug(name) { ':change_disc!' }
          # handle_change_disc(request_mode: command.mode.value)
          # send_status(current_state)
          # handle_play
        else
          LogActually.cdc.warn(name) { "Control: #{control}, not handled?" }
          return false
        end
      end

      # Radio Request Handling

      def handle_status_request
        LogActually.cdc.debug(ident) { 'Handling CDC status.' }
      end

      def handle_stop
        LogActually.cdc.debug(ident) { 'Handling disc stop.' }

        new_state = { control: CONTROL[:stopped],
                      status: STATUS[:idle] }
        state!(new_state)
      end

      def handle_play
        LogActually.cdc.debug(ident) { 'Handling disc play.' }
        state!(control: CONTROL[:playing], status: STATUS[:active])
        case current_control
        when CONTROL[:fwd]
          state!(track: next_track) if too_short_to_be_scan?
        when CONTROL[:rwd]
          state!(track: previous_track) if too_short_to_be_scan?
        when CONTROL[:off]
          state!(cd: 0, track: 0)
        when CONTROL[:playing]
          state!(cd: 1, track: current_track)
        else
          LogActually.cdc.warn(ident) { 'handle play current control not handled?' }
          state!(cd: 9, track: 99)
        end
      end

      def handle_seek(request_mode:)
        LogActually.cdc.debug(ident) { "#handle_seek(#{mode})" }
        # LogActually.cdc.debug(ident) { 'Handling track skip.' }

        case request_mode
        when 0
          LogActually.cdc.debug(ident) { "mode 0 => next_track" }
          control = CONTROL[:next]
          track = next_track
        when 1
          LogActually.cdc.debug(ident) { "mode 1 => previous_track" }
          control = CONTROL[:previous]
          track = previous_track
        else
            LogActually.cdc.warn(ident) { "mode #{mode} => ???" }
        end

        state!(control: control, status: STATUS[:active], track: track)
        start_timer
      end

      def handle_scan(request_mode:)
        LogActually.cdc.debug(ident) { 'Handling track scan.' }

        case request_mode
        when 0
          LogActually.cdc.debug(ident) { "mode 0 => fwd" }
          control = CONTROL[:fwd]
        when 1
          LogActually.cdc.debug(ident) { "mode 0 => rwd" }
          control = CONTROL[:rwd]
        end

        state! control: control, status: STATUS[:idle]
        start_timer
      end

      def handle_change_disc(request_mode:)
        LogActually.cdc.debug(ident) { 'Handling disc change.' }

        requested_disc = request_mode
        LogActually.cdc.debug(ident) { "Requested disc: #{requested_disc}" }

        new_state = { control: CONTROL[:changed],
                      status: STATUS[:active],
                      cd: requested_disc,
                      track: 1 }
        state!(new_state)
      end
    end
  end
end
