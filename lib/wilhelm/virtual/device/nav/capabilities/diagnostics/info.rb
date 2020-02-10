# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Navigation
        module Capabilities
          module Diagnostics
            # Navigation::Capabilities::Diagnostics::Info
            module Info
              include API
              
              INFO_PART_NUMBER  = [0x36, 0x39, 0x32, 0x30, 0x31, 0x38, 0x32].freeze
              INFO_HW_NUMBER    = [0x31, 0x30].freeze
              INFO_CODING_INDEX = [0x30, 0x38].freeze
              INFO_DIAG_INDEX   = [0x30, 0x36].freeze
              INFO_BUS_INDEX    = [0x31, 0x34].freeze
              INFO_MANU_DATE    = [0x32, 0x35, 0x30, 0x33].freeze
              INFO_SUPPLIER     = [0x30, 0x31, 0x30, 0x38, 0x37, 0x38, 0x38, 0x2e, 0x31, 0x30].freeze
              INFO_SW_NUMBER    = [0x30, 0x30].freeze

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

              def info!(data = info)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
