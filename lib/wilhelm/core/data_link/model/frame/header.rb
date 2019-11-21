# frozen_string_literal: false

module Wilhelm
  module Core
    module DataLink
      class Frame < Bytes
        # Core::DataLink::Frame::Header
        class Header < Bytes
          include Errors
          VALID_SIZE = (2..2)

          MIN_LENGTH_VALUE = (3..255)
          LENGTH_INDEX = 1

          MSG_INVALID_SIZE = 'invalid header length'.freeze
          MSG_LENGTH_INVALID = 'invalid frame length'.freeze

          def initialize(bytes)
            validate_args(bytes)
            super(bytes)
          end

          def from
            self[0]
          end

          def tail
            self[1]
          end

          def tail_length
            self[1]
          end

          private

          def validate_args(bytes)
            raise(HeaderValidationError, MSG_INVALID_SIZE) unless VALID_SIZE.include?(bytes.length)
            tail_length_value = bytes[LENGTH_INDEX]
            raise HeaderImplausibleError, MSG_LENGTH_INVALID unless MIN_LENGTH_VALUE.include?(tail_length_value)
          end
        end
      end
    end
  end
end
