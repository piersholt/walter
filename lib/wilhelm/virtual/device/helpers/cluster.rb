# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Device::Helpers
        module Cluster
          HUD_SIZE = 20

          LEFT = :ljust
          CENTERED = :center
          RIGHT = :rjust

          ALIGNMENTS = [LEFT, CENTERED, RIGHT].freeze

          def align(chars_string, alignment = CENTERED)
            raise ArgumentError, "Invalid alignment #{alignment}" unless ALIGNMENTS.include?(alignment)
            chars_string.public_send(alignment, HUD_SIZE)
          end

          def format_chars!(command_arguments, opts = { align: :center })
            chars_string = command_arguments[:chars]
            return false unless chars_string

            align(chars_string, opts[:align])

            chars_array = chars_string.bytes
            command_arguments[:chars] = chars_array
          end
        end
      end
    end
  end
end
