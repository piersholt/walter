# frozen_string_literal: true

# Comment
class Wilhelm::Virtual
  # Comment
  class EmulatedCDC < EmulatedDevice
    # include Constants
    # include State
    include Handlers
    include Capabilities::CDChanger
    # include Capabilities::GFX
    # include Capabilities::Radio

    attr_reader :message, :from, :to,
                :command, :command_id,
                :control, :control_value,
                :mode, :mode_value

    PROC = 'EmulatedCDC'

    def name
      'EmulatedCDC'
    end

    def logger
      LogActually.cdc
    end

    def handle_virtual_receive(message)
      id = message.command.normal_fucking_decimal
      case id
      when CDC_REQ
        LogActually.cdc.debug(ident) { "#handle_message => CDC_REQ (#{CDC_REQ})" }
        handle_cd_changer_request(message.command)
      # when TXT_GFX
      #   handle_cd_changer_request(message.command)
      end

      super(message)
    rescue StandardError => e
      LOGGER.error e
    end
  end
end
