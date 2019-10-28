# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GT
            # Diagnostics::Capabilities::GT::Coding
            module Coding
              include Constants

              # READ
              def gt_coding(offset = 0x00, length = 0x10)
                return false unless valid_gt_coding_length?(length)
                return false unless valid_gt_coding_offset?(offset, length)
                coding_read(to: :gt, arguments: [0x00, offset, length])
              end

              def gt_coding_dump
                GT_CODING_BLOCKS.each do |block|
                  gt_coding(block.offset, block.size)
                  sleep(0.25)
                end
              end

              private

              def valid_gt_coding_length?(length)
                VALID_GT_CODING_BLOCK_SIZE.cover?(length)
              end

              def valid_gt_coding_offset?(offset, length)
                VALID_GT_CODING_OFFSET.cover?(offset + length)
              end
            end
          end
        end
      end
    end
  end
end
