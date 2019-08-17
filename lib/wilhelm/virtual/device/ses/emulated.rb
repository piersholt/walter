# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module SES
        # SES::Emulated
        class Emulated < Device::Emulated
          PROC = 'SES::Emulated'

          SUBSCRIBE = [PING].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when SES
              logger.unknown(PROC) { "Rx: SES 0x#{d2h(SES)}" }
            end

            super(message)
          end
        end
      end
    end
  end
end
