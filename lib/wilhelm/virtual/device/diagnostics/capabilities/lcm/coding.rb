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

              # 18 blocks @ 32 bytes
              # "block" addressing
              VALID_LCM_CODING_ADDRESS = (0x00..0x12)

              # READ
              # 3F 04 D0 08 (00..12) E3
              def lcm_coding(address)
                return false unless valid_lcm_coding_address?(address)
                coding_read(to: :lcm, arguments: [address])
              end

              private

              def valid_lcm_coding_address?(address)
                VALID_LCM_CODING_ADDRESS.cover?(address)
              end
            end
          end
        end
      end
    end
  end
end
