# frozen_string_literal: false

module Wilhelm
  module Core
    module DataLink
      class Frame < Bytes
        # Core::DataLink::Frame::Tail
        class Tail < Bytes
          include Errors
          # D-Bus (2..255)
          VALID_SIZE = (3..255)

          MSG_INVALID_SIZE = 'invalid tail length'.freeze

          def initialize(bytes)
            validate_args(bytes)
            super(bytes)
          end

          def without_fcs
            self[0..-2]
          end

          def to
            self[0]
          end

          def command
            self[1]
          end

          def payload
            self[1..-2]
          end

          # a command may not have any arguments
          def arguments
            length > 3 ? self[2..-2] : []
          end

          def fcs
            self[-1]
          end

          def no_fcs
            self[0..-2]
          end

          alias checksum fcs

          private

          def validate_args(bytes)
            return true if VALID_SIZE.include?(bytes.length)
            raise(TailValidationError, MSG_INVALID_SIZE)
          end
        end
      end
    end
  end
end
