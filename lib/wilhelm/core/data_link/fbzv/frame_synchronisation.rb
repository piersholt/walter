# frozen_string_literal: true

module Wilhelm
  module Core
    module FBZV
      class Frame
        class Synchronisation
          include Wilhelm::Helpers::DataTools
          
          attr_reader :buffer, :frame

          SYNC = 'Sync /'
          SYNC_HEADER = 'Header /'
          SYNC_TAIL = 'Tail /'
          SYNC_VALIDATION = 'Validate /'
          SYNC_SHIFT = 'Unshift! /'

          def initialize(buffer, opts = { offset: 0 })
            @buffer = buffer
            @offset = opts[:offset]
          end

          def run
            shift
          end

          def all_bytes
            frame[0..-1].join(' ')
          end

          def formatted_frame
            "#{all_bytes}"
          end

          def shift(read_buffer = [], read_length = 11)
            @frame = read_buffer + buffer.shift(read_length)
            validate_frame
            LOGGER.debug(name) { formatted_frame }
            frame
          rescue ChecksumError => e
            LOGGER.warn(name) { formatted_frame }
            shift(frame, 1)
          end


          private

          def name
            'Synchronisation'
          end

          # def checksum
          #   frame[0..-2].reduce(0) { |x, y| x^=y.d }
          # end

          def frame_check
            true
          end

          def validate_frame
            result = frame_check
            raise ChecksumError unless result
          end
        end
      end
    end
  end
end
