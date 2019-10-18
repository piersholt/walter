# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Memory
            module Memory
              include Wilhelm::Helpers::PositionalNotation
              include Constants

              # TODO: confirm in INPA
              VALID_MEMORY_ADDRESS = (0x00_00..0xFF_FF)

              # READ
              # 3F 05 D0 06 00 00 EC
              # 3F 05 D0 06 00 16 FA
              # 3F 05 D0 06 00 32 DE
              def lcm_memory(*address)
                return false unless valid_lcm_memory_address?(*address)
                memory_read(to: :lcm, arguments: [*address])
              end

              # WRITE
              def lcm_memory!(*)
                false
              end

              private

              def valid_lcm_memory_address?(*address)
                VALID_MEMORY_ADDRESS.cover?(parse_base_256_digits(*address))
              end
            end
          end
        end
      end
    end
  end
end
