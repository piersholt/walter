# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Diagnostics
            # Radio::Capabilities::Diagnostics::Info
            module Info
              include API

              INFO_PART_NUMBER  = [0x86, 0x90, 0x42, 0x13].freeze
              INFO_HW_NUMBER    = [0x01].freeze
              INFO_CODING_INDEX = [0x01].freeze
              INFO_DIAG_INDEX   = [0x32].freeze
              INFO_BUS_INDEX    = [0x11].freeze
              INFO_MANU_DATE    = [0x42, 0x01].freeze
              INFO_SUPPLIER     = [0x20].freeze
              INFO_SW_NUMBER    = [0x63].freeze
              INFO_UNKNOWN      = [0x30, 0x33].freeze

              INFO = [
                *INFO_PART_NUMBER,
                *INFO_HW_NUMBER,
                *INFO_CODING_INDEX,
                *INFO_DIAG_INDEX,
                *INFO_BUS_INDEX,
                *INFO_MANU_DATE,
                *INFO_SUPPLIER,
                *INFO_SW_NUMBER,
                *INFO_UNKNOWN
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
