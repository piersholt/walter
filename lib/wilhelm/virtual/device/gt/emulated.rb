# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        # GT::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include API

          PROC = 'GT::Emulated'

          # INFO --------------------------------------------------------------

          # MK4
          INFO_PART_NUMBER  = [0x36, 0x39, 0x32, 0x30, 0x31, 0x38, 0x32].freeze
          INFO_HW_NUMBER    = [0x31, 0x30].freeze
          INFO_CODING_INDEX = [0x30, 0x38].freeze
          INFO_DIAG_INDEX   = [0x30, 0x36].freeze
          INFO_BUS_INDEX    = [0x31, 0x34].freeze
          INFO_MANU_DATE    = [0x32, 0x35, 0x30, 0x33].freeze
          INFO_SW_NUMBER    = [0x30, 0x30].freeze
          INFO_SUPPLIER     = [
            0x30, 0x31, 0x30, 0x38, 0x37, 0x38, 0x38, 0x2E, 0x31, 0x30
          ].freeze

          # MK1 VM
          # INFO_PART_NUMBER  = [0x38, 0x33, 0x37, 0x35, 0x31, 0x32, 0x36].freeze
          # INFO_HW_NUMBER    = [0x35, 0x30].freeze
          # INFO_CODING_INDEX = [0x30, 0x31].freeze
          # INFO_DIAG_INDEX   = [0x30, 0x31].freeze
          # INFO_BUS_INDEX    = [0x30, 0x35].freeze
          # INFO_MANU_DATE    = [0x30, 0x37, 0x39, 0x37].freeze
          # INFO_SW_NUMBER    = [0x30, 0x30].freeze
          # INFO_SUPPLIER     = [
          #   0x31, 0x30, 0x33, 0x37, 0x30, 0x38, 0x32, 0x31, 0x37, 0x32
          # ].freeze

          INFO = [
            *INFO_PART_NUMBER,
            *INFO_HW_NUMBER,
            *INFO_CODING_INDEX,
            *INFO_DIAG_INDEX,
            *INFO_BUS_INDEX,
            *INFO_MANU_DATE,
            *INFO_SUPPLIER,
            *INFO_SW_NUMBER
          ].freeze

          def info
            @info ||= INFO.dup
          end

          def info!
            @info = INFO.dup
          end

          # CODING ------------------------------------------------------------

          # 0x00 = "ECE" EUROPE
          # 0x01 = "US_CDN"
          # 0x02 = AUSTRALIA

          CODING = [
            0x00, 0x01, 0x03, 0x02,
            0x42, 0x5a, 0x30, 0x30, 0x39, 0x30, 0x31,
            # Vehicle
            0x21,
            # Options
            0x23,
            # Radio
            0x00,
            0x00, 0x00,
            0x2b, 0x36, 0x31, 0x34, 0x31, 0x31, 0x31, 0x31,
            0x31, 0x31, 0x31, 0x31, 0x20, 0x20, 0x00, 0x00,
            0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
            0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00, 0x00,
            0x2b, 0x36, 0x31, 0x34, 0x32, 0x32, 0x32, 0x32,
            0x32, 0x32, 0x32, 0x32, 0x20, 0x20, 0x00, 0x00,
            0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
            0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00, 0x00,
            0x2b, 0x36, 0x31, 0x34, 0x33, 0x33, 0x33, 0x33,
            0x33, 0x33, 0x33, 0x33, 0x20, 0x20
          ].freeze

          SUBSCRIBE = [
            PING,
            DIA_HELLO,
            DIA_COD_READ
          ].freeze

          def coding
            @coding ||= CODING.dup
          end

          def coding!
            @coding = CODING.dup
            coding.join(' ')
          end

          def country_variant
            coding[0]
          end

          def country_variant=(byte)
            coding[0] = byte
          end

          def speed_map
            coding[1]
          end

          def speed_map=(byte)
            coding[1] = byte
          end

          alias cv country_variant=

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when DIA_HELLO
              logger.debug(PROC) { "Rx: DIA_HELLO 0x#{d2h(DIA_HELLO)}" }
              a0(arguments: info)
            when DIA_COD_READ
              logger.debug(PROC) { "Rx: DIA_COD_READ 0x#{d2h(DIA_COD_READ)}" }
              offset, length = message.command.arguments[1, 2]
              a0(arguments: coding.slice(offset, length))
            end

            super(message)
          end
        end
      end
    end
  end
end
