# frozen_string_literal: true

# Comment
class Virtual
  class SimulatedDSP < EmulatedDevice
    PROC = 'SimulatedDSP'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when DSP_EQ
        true
      end

      super(message)
    end
  end
end
