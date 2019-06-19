# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class SimulatedDSP < EmulatedDevice
      PROC = 'SimulatedDSP'.freeze

      def handle_virtual_receive(message)
        command_id = message.command.d
        case command_id
        when DSP_EQ
          true
        end

        super(message)
      end
    end
  end
end
