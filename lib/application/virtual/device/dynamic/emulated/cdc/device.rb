# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class SimulatedCDC < EmulatedDevice
    include Constants
    include ChangerRequest

    attr_reader :message, :from, :to,
                :command, :command_id,
                :control, :control_value,
                :mode, :mode_value

    PROC = 'SimulatedCDC'

    def name
      'SimulatedCDC'
    end

    def message=(message)
      @message = message
      @from = message.from
      @to = message.to
      @command = message.command
      @command_id = command.d
      @control = command.control
      @control_value = control.d
      @mode = command.mode
      @mode_value = mode.d
    end

    def handle_message(message)
      public_send(:message=, message)
      LOGGER.debug(PROC) { "Handle? #{from} -> #{command.h}" }

      case command_id
      when CDC_REQ
        changer_request(message)
      end

      super(message)
    end
  end
end
