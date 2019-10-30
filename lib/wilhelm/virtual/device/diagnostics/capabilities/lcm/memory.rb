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

              DEFAULT_LCM_CODING_BLOCK_SIZE = 0x20
              # Fixed block size of 32 bytes, but byte addressing.
              VALID_LCM_MEMORY_ADDRESSES = (
                0x00_00..0xff_ff - DEFAULT_LCM_CODING_BLOCK_SIZE
              )

              # READ
              # 3F 05 D0 06 00 00 EC
              # 3F 05 D0 06 00 16 FA
              # 3F 05 D0 06 00 32 DE
              # @note byte addressing!
              # @note no block size! (default of 0x20/32 bytes)
              def lcm_memory(*address)
                return false unless valid_lcm_memory_address?(*address)
                memory_read(to: :lcm, arguments: [*address])
              end

              private

              def valid_lcm_memory_address?(*address)
                VALID_LCM_MEMORY_ADDRESSES.cover?(parse_base_256_digits(*address))
              end
            end
          end
        end
      end
    end
  end
end
