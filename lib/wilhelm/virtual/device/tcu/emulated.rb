# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TCU
        # TCU::Emulated
        class Emulated < Device::Emulated
          PROC = 'TCU::Emulated'

          SUBSCRIBE = [PING, 0xA9].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            logger.debug(PROC) { "Rx: #{message}" }

            super(message)
          end
        end
      end
    end
  end
end
