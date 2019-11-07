# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Navigation::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include Capabilities

          PUBLISH   = [ASSIST].freeze
          SUBSCRIBE = [ASSIST].freeze

          PROC = 'Navigation::Augmented'

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)
            case command_id
            when ASSIST
              logger.debug(PROC) { "Tx: ASSIST #{d2h(ASSIST)}" }
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when ASSIST
              logger.debug(PROC) { "Rx: ASSIST #{d2h(ASSIST)}" }
            end
          end
        end
      end
    end
  end
end
