# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Coding
            module Coding
              include Constants
              # 3F 04 D0 08 00 E3
              # 3F 04 D0 08 01 E2
              # 3F 04 D0 08 02 E1
              # 3F 04 D0 08 03 E0
              # 3F 04 D0 08 04 E7
              # 3F 04 D0 08 05 E6
              # 3F 04 D0 08 06 E5
              # 3F 04 D0 08 07 E4
              # 3F 04 D0 08 08 EB
              # 3F 04 D0 08 09 EA
              # 3F 04 D0 08 0A E9
              # 3F 04 D0 08 0B E8
              # 3F 04 D0 08 0C EF
              # 3F 04 D0 08 0D EE
              # 3F 04 D0 08 0E ED
              # 3F 04 D0 08 0F EC
              # 3F 04 D0 08 10 F3
              # 3F 04 D0 08 11 F2
              # 3F 04 D0 08 12 F1

              def lcm_coding(address)
                return false unless (0x00..0x12).cover?(address)
                coding_read(to: :lcm, arguments: [address])
              end
            end
          end
        end
      end
    end
  end
end
