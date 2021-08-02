# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module EHC
        # EHC::Emulated
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'EHC::Emulated'

          SUBSCRIBE = [PING, 0x00, 0x9e].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when 0x00
              logger.error(PROC) { "Rx: 0x00" }
              info!
            end

            super(message)
          end
        end
      end
    end
  end
end
