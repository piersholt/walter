# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Memory
            module Memory
              include Constants

              # TODO: confirm in INPA
              VALID_MEMORY_ADDRESS = (0x00..0x00)

              # READ
              # 3F 05 D0 06 00 00 EC
              # 3F 05 D0 06 00 16 FA
              # 3F 05 D0 06 00 32 DE

              def lcm_memory(*)
                false
              end

              # WRITE

              def lcm_memory!(*)
                false
              end

              private

              def valid_lcm_memory_address?(address)
                VALID_MEMORY_ADDRESS.cover?(address)
              end
            end
          end
        end
      end
    end
  end
end
