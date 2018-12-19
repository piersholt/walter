# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class SimulatedCDC < EmulatedDevice
    # Simulated CD Changer
    module ChangerRequest
      include Constants
      include API::CDChanger

      # Command Delegate
      def changer_request(message)
        delegate_changer_request(message.command)
        status(current_state)
      end

      def delegate_changer_request(command)
        control = command.control
        case control.value
        when REQUEST[:status]
          handle_status_request
        when REQUEST[:stop]
          handle_stop
        when REQUEST[:play]
          handle_play
        when REQUEST[:skip]
          handle_skip(command)
        when REQUEST[:seek]
          handle_seek(command)
        when REQUEST[:change_disc]
          handle_change_disc(command)
          status(current_state)
          handle_play
        else
          LOGGER.warn(name) { "Control: #{control}, not handled?" }
          return false
        end
      end

      def status(current_state)
        cd_changer_status(from: me, to: :rad, arguments: current_state)
      end

      # Radio Request Handling

      def handle_status_request
        LOGGER.unknown(ident) { 'Handling CDC status.' }

        status
      end

      def handle_stop
        LOGGER.unknown(ident) { 'Handling disc stop.' }

        new_state = { control: CONTROL[:stop],
                      status: STATUS[:no] }
        state!(new_state)
      end

      def handle_play
        LOGGER.unknown(ident) { 'Handling disc play.' }
        state! control: CONTROL[:start], status: STATUS[:yes]
        case current_control
        when CONTROL[:fwd]
          state!(track: next_track) if only_skip_track?
        when CONTROL[:rwd]
          state!(track: previous_track) if only_skip_track?
        when CONTROL[:off]
          state!(cd: 1, track: 1)
        else
          state!(cd: 7, track: 99)
        end
      end

      def handle_skip(command)
        LOGGER.unknown(ident) { 'Handling track skip.' }

        mode = command.mode

        if mode.value.zero?
          control = CONTROL[:next]
          track = next_track
        elsif mode.value == 1
          control = CONTROL[:previous]
          track = previous_track
        end

        state! control: control, status: STATUS[:no], track: track
        start_timer
      end

      def handle_seek(command)
        LOGGER.unknown(ident) { 'Handling track scan.' }

        mode = command.mode

        if mode.value.zero?
          control = CONTROL[:fwd]
        elsif mode.value == 1
          control = CONTROL[:rwd]
        end

        state! control: control, status: STATUS[:no]
        start_timer
      end

      def handle_change_disc(command)
        LOGGER.unknown(ident) { 'Handling disc change.' }

        requested_disc = command.mode
        LOGGER.debug(ident) { "Requested disc: #{requested_disc.value}" }

        new_state = { control: CONTROL[:changed],
                      status: STATUS[:yes],
                      cd: requested_disc.value,
                      track: 1 }
        state!(new_state)
      end
    end
  end
end
