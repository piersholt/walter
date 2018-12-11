# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class SimulatedCDC < SimulatedDevice
    include ChangerRequest

    PROC = 'SimulatedCDC'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when CHANGER_REQUEST
        handle_changer_request(message)
      end

      super(message)
    end
  end
end
