# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        # API::Display::Cache::Value
        class Value
          extend Forwardable
          attr_reader :char_array, :dirty
          BLANK_CHAR = 0x20.chr
          EMPTY_ARRAY = [].freeze

          def_delegators :char_array, :empty?

          def initialize(char_array = EMPTY_ARRAY.dup, dirty: false)
            raise ArgumentError, 'Argument char_array is not an Array!' unless char_array.is_a?(Array) || char_array.is_a?(Core::Bytes)
            @char_array = char_array
            @dirty = dirty
          end

          def blank?
            char_array.all? { |c| c == BLANK_CHAR }
          end

          def to_s
            char_array.map(&:chr).join
          end

          def inspect
            # "#<Value:#{hex_id} @char_array=#{char_array} (\"#{to_s}\")>"
            # "#<#{self.class.name}:#{hex_id} @char_array=#{char_array}>"
            "\"#{to_s}\" #{char_array}"
          end

          def hex_id
            Kernel.format('%#.14x',(object_id * 2))
          end
        end
      end
    end
  end
end
