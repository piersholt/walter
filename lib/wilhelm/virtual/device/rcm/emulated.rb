# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module RCM
        # RCM::Emulated
        class Emulated < Device::Emulated
          include Capabilities::Ready

          PROC = 'RCM::Emulated'

          SUBSCRIBE = [PING, 0x9e].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when 0x9e
              logger.debug(PROC) { "Rx: UNKNOWN 0x#{d2h(0x9e)}" }
            end

            super(message)
          end
        end
      end
    end
  end
end
