# frozen_string_literal: false

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Frame < Bytes
        # Comment
        class Header < Bytes
          VALID_SIZE = (2..2)

          MIN_LENGTH_VALUE = (3..255)
          LENGTH_INDEX = 1

          def initialize(bytes)
            validate_args(bytes)
            super(bytes)
          end

          # ************************************************************************* #
          #                                 BYTE MAP
          # ************************************************************************* #

          def from
            self[0]
          end

          def tail
            self[1]
          end

          # ************************************************************************* #
          #                             HEADER PROPERTIES
          # ************************************************************************* #

          def tail_length
            self[1].d
          end

          private
          
          def validate_args(bytes)
            raise HeaderValidationError, 'invalid header length'  unless VALID_SIZE.include?(bytes.length)
            tail_length_value = bytes[LENGTH_INDEX].d
            raise HeaderImplausibleError, 'invalid frame length' unless MIN_LENGTH_VALUE.include?(tail_length_value)
          end
        end
      end
    end
  end
end
