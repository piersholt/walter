# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GT
            # Diagnostics::Capabilities::GT::Constants
            module Constants
              Block = Struct.new(:offset, :size)

              # 1 to 32 bytes
              VALID_GT_CODING_BLOCK_SIZE = (0x01..0x20)
              VALID_GT_CODING_OFFSET    = (0x00..0x93)

              # Size: 94 bytes
              GT_CODING_BLOCKS = [
                Block.new(0x00, 0x10),
                Block.new(0x10, 0x10),
                Block.new(0x20, 0x10),
                Block.new(0x30, 0x10),
                Block.new(0x40, 0x10),
                Block.new(0x50, 0x0e)
              ].freeze
            end
          end
        end
      end
    end
  end
end
