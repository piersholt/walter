# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT2
        # GT2::Emulated
        class Emulated < Device::Emulated
          include API
          PROC = 'GT2::Emulated'

          SUBSCRIBE = [PING, 0xAB].freeze

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
