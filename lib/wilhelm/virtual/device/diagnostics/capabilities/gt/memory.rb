# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GT
            # Diagnostics::Capabilities::GT::Memory
            module Memory
              # READ
              # appears to be fixed memory size of 8 bytes
              # [00] (00 FF FF FF) (00 81 80 86)
              # @note no block size! (default of 0x20/32 bytes)
              # @note no address- default of 0x00!
              def gt_memory(*args)
                memory_read(to: :gt, arguments: [*args])
              end

              # WRITE
              # 3F 09 3B 07 [01] (FF FF FF FF 00) 0B
              # 3F 09 3B 07 [01] (FF 81 FF 86 00) 0C
            end
          end
        end
      end
    end
  end
end
