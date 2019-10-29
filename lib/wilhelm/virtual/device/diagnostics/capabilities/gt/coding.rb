# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GT
            # Diagnostics::Capabilities::GT::Coding
            module Coding
              Block = Struct.new(:address, :size)

              # 1 to 32 bytes
              VALID_GT_CODING_BLOCK_SIZE = (1..32)
              VALID_GT_CODING_ADDRESS    = (0x00..0x93)

              # Size: 94 bytes
              GT_CODING_BLOCKS = [
                Block.new(0x00, 0x10),
                Block.new(0x10, 0x10),
                Block.new(0x20, 0x10),
                Block.new(0x30, 0x10),
                Block.new(0x40, 0x10),
                Block.new(0x50, 0x0e)
              ].freeze

              # READ
              # @note byte addressing!
              # @note variable length blocks!
              def gt_coding(address = 0x00, length = 16)
                return false unless valid_gt_coding_length?(length)
                return false unless valid_gt_coding_address?(address, length)
                coding_read(to: :gt, arguments: [0x00, address, length])
              end

              def gt_coding_dump
                GT_CODING_BLOCKS.each do |block|
                  gt_coding(block.address, block.size)
                  sleep(0.25)
                end
              end

              private

              def valid_gt_coding_length?(length)
                VALID_GT_CODING_BLOCK_SIZE.cover?(length)
              end

              def valid_gt_coding_address?(address, length)
                VALID_GT_CODING_ADDRESS.cover?(address + length)
              end
            end
          end
        end
      end
    end
  end
end
