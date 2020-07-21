# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module IHKA
            # Diagnostics::Capabilities::IHKA::Memory
            module Memory
              include Wilhelm::Helpers::PositionalNotation
              include Constants

              # HACK-TASTIC!

              DEFAULT_IHKA_CODING_BLOCK_SIZE = 0x20
              # Fixed block size of 32 bytes, but byte addressing.
              VALID_IHKA_MEMORY_ADDRESSES = (
                0x00_00..0x0f_ff - DEFAULT_IHKA_CODING_BLOCK_SIZE
              )

              # READ
              # 3F 05 D0 06 00 00 EC
              # 3F 05 D0 06 00 16 FA
              # 3F 05 D0 06 00 32 DE
              # 3f .. 5b 06 00 00 03 60 20 ..
              # @note byte addressing!
              def ihka_memory(address)
                # return false unless valid_ihka_memory_address?(address)
                msb = (address & 0xff_00) >> 8
                lsb = (address & 0x00_ff) >> 0
                memory_read(
                  to: :ihka,
                  arguments: [
                    0x00, 0x00,
                    msb, lsb,
                    DEFAULT_IHKA_CODING_BLOCK_SIZE
                  ]
                )
              end

              private

              def valid_ihka_memory_address?(address)
                VALID_IHKA_MEMORY_ADDRESSES.cover?(parse_base_256_digits(address))
              end
            end
          end
        end
      end
    end
  end
end
