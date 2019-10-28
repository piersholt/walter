# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Navigation::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include API

          PROC = 'Navigation::Emulated'

          INFO_PART_NUMBER  = [0x36, 0x39, 0x32, 0x30, 0x31, 0x38, 0x32].freeze
          INFO_HW_NUMBER    = [0x31, 0x30].freeze
          INFO_CODING_INDEX = [0x30, 0x38].freeze
          INFO_DIAG_INDEX   = [0x30, 0x36].freeze
          INFO_BUS_INDEX    = [0x31, 0x34].freeze
          INFO_MANU_DATE    = [0x32, 0x35, 0x30, 0x33].freeze
          INFO_SW_NUMBER    = [0x30, 0x30].freeze

          INFO = [
            *INFO_PART_NUMBER,
            *INFO_HW_NUMBER,
            *INFO_CODING_INDEX,
            *INFO_DIAG_INDEX,
            *INFO_BUS_INDEX,
            *INFO_MANU_DATE,
            # Unknown
            0x30, 0x31, 0x30, 0x38, 0x37,
            0x38, 0x38, 0x2E, 0x31, 0x30,
            *INFO_SW_NUMBER
          ].freeze

          def info
            @info ||= INFO.dup
          end

          def info!
            @info = INFO.dup
          end

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
              a0(arguments: INFO)
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
