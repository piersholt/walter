# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Device::Helpers
        module Cluster
          HUD_SIZE = 20

          LEFT   = :ljust
          CENTRE = :center
          RIGHT  = :rjust

          ALIGNMENTS = [LEFT, CENTRE, RIGHT].freeze

          def align(chars_string, alignment = CENTRE)
            validate_alignment(alignment)
            chars_string.public_send(alignment, HUD_SIZE)
          end

          def format_chars!(command_arguments, alignment: CENTRE)
            return false unless command_arguments.key?(:chars)
            chars_string = command_arguments.fetch(:chars)
            return false if char_array?(chars_string)
            validate_chars_string(chars_string)

            align(chars_string, alignment)

            command_arguments[:chars] = chars_string.bytes
          end

          def validate_chars_string(chars_string)
            return true if chars_string.is_a?(String)
            raise(ArgumentError, error_chars_type(chars_string))
          end

          def error_chars_type(chars_string)
            "format_chars!: chars must be String, but is #{chars_string.class}"
          end

          def chars_array?(chars_string)
            return false unless chars_string.is_a?(Array)
            return false unless chars_string.all? { |i| i.is_a?(Integer) }
            true
          end

          def validate_alignment(alignment)
            return true if ALIGNMENTS.include?(alignment)
            raise(ArgumentError, error_alignment(alignment))
          end

          def error_alignment(alignment)
            "Invalid alignment #{alignment}"
          end
        end
      end
    end
  end
end
