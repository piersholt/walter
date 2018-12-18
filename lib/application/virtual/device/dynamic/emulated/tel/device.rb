# frozen_string_literal: true

# Comment
class Virtual
  class SimulatedTEL < EmulatedDevice
    include Telephone

    PROC = 'SimulatedTEL'.freeze

    def handle_message(message)
      command_id = message.command.d
      LOGGER.debug('SimulatedTEL!') { "handle message id: #{command_id}" }
      case command_id
      when PONG
        LOGGER.debug('SimulatedTEL!') { "handling pong" }
        handle_announce(message)
      when GFX_STATUS
        handle_gfx_status(message)
      when TEL_DATA
        handle_data_request(message)
      when TEL_OPEN
        handle_tel_open(message)
      end

      super(message)
    end
  end
end
