# frozen_string_literal: true

# Comment
module Wilhelm
  class Virtual
    class EmulationDummy < EmulatedDevice
      PROC = 'EmulationDummy'.freeze

      def handle_virtual_receive(message)
        command_id = message.command.d
        case command_id
        when 266
          false
        end

        super(message)
      end
    end
  end
end
