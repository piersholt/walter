# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GM
        # Device::GM::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include Capabilities

          PUBLISH   = [VIS_ACK].freeze
          SUBSCRIBE = [].freeze

          PROC = 'GM::Augmented'

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)
            case command_id
            when VIS_ACK
              logger.debug(moi) { "Tx: VIS_ACK #{d2h(command_id)}" }
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
          end
        end
      end
    end
  end
end
