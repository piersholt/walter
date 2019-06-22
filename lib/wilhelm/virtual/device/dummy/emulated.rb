# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Dummy
        # Comment
        class Emulated < EmulatedDevice
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
  end
end
