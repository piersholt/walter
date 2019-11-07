# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Navigation::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include Capabilities

          PROC = 'Navigation::Emulated'

          SUBSCRIBE = [
            PING,
            # IGNITION_REP,
            DIA_HELLO,
            DIA_COD_READ
          ].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when DIA_HELLO
              logger.debug(PROC) { "Rx: DIA_HELLO 0x#{d2h(DIA_HELLO)}" }
              info
            # when DIA_COD_READ
            #   logger.debug(PROC) { "Rx: DIA_COD_READ 0x#{d2h(DIA_COD_READ)}" }
            #   offset, length = message.command.arguments[1, 2]
            #   a0(arguments: CODING.slice(offset, length))
            end

            super(message)
          end
        end
      end
    end
  end
end
