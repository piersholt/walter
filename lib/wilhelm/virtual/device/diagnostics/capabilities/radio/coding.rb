# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Radio
            # Diagnostics::Capabilities::Radio::Coding
            module Coding
              include Constants

              # Original
              # 03 00 00 03 41 01 00 00
              # Write
              # 00 03 00 00 03 41 01 00 00
              # => B0!
              # Read
	            # 03 00 00 03 03 01 00 00
              # Write 2
              # 03 00 00 03 41 01 00 00
              # => A0
              # Read
              # 03 00 00 03 41 01 00 00
              # READ
              # 3F 04 68 08 ..
              def rad_coding
                coding_read(to: :rad, arguments: [])
              end

              AREA = {
                ece: 0x00,
                us: 0x01,
                jp: 0x02,
                oce: 0x03
              }.freeze

              TP = {
                on: 0x04,
                off: 0x00
              }

              RADIO_CODING = [
                0x03, 0x00, 0x00, 0x03, 0x41, 0x01, 0x00, 0x00
              ].freeze

              # [0x07, 0x04, 0x19, 0x01, 0x40, 0x01, 0x01, 0x00]

              def rad_coding!(coding_data = RADIO_CODING)
                coding_write(to: :rad, arguments: [*coding_data])
              end
            end
          end
        end
      end
    end
  end
end
