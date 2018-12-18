# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class SimulatedCDC < EmulatedDevice
    include ChangerRequest

    PROC = 'SimulatedCDC'.freeze

    def handle_message(message)
      command_id = message.command.d
      LOGGER.debug(PROC) { "Handle? #{message.from} -> #{message.command.h}" }

      case command_id
      when CDC_REQ
        handle_changer_request(message)
      end

      super(message)
    end
  end
end
