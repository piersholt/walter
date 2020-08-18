# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          module Diagnostics
            # LCM::Capabilities::Diagnostics::Info
            module Info
              include API

              #             PN .. .. .. HW CI DI BI DATE  SU SW
              # D0 0F 3F A0 06 90 84 65 02 18 13 00 07 01 09 42 73

              INFO_PART_NUMBER  = [0x06, 0x90, 0x84, 0x65].freeze
              INFO_HW_NUMBER    = [0x02].freeze
              INFO_CODING_INDEX = [0x18].freeze
              INFO_DIAG_INDEX   = [0x13].freeze
              INFO_BUS_INDEX    = [0x00].freeze
              INFO_MANU_DATE    = [0x07, 0x01].freeze
              INFO_SUPPLIER     = [0x09].freeze
              INFO_SW_NUMBER    = [0x42].freeze

              def info
                [
                  *part_number,
                  *hw_number,
                  *coding_index,
                  *diag_index,
                  *bus_index,
                  *manu_date,
                  *supplier,
                  *sw_number
                ]
              end

              def info!(data = info)
                a0(arguments: data)
              end

              def part_number
                @part_number ||= INFO_PART_NUMBER
              end

              def hw_number
                @hw_number ||= INFO_HW_NUMBER
              end

              def coding_index
                @coding_index ||= INFO_CODING_INDEX
              end

              def diag_index
                @diag_index ||= INFO_DIAG_INDEX
              end

              def bus_index
                @bus_index ||= INFO_BUS_INDEX
              end

              def manu_date
                @manu_date ||= INFO_MANU_DATE
              end

              def supplier
                @supplier ||= INFO_SUPPLIER
              end

              def sw_number
                @sw_number ||= INFO_SW_NUMBER
              end
            end
          end
        end
      end
    end
  end
end
