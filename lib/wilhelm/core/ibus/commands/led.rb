# frozen_string_literal: false

module Wilhelm
  module Core
    class Command
      class LED < BaseCommand
        # attr_reader :led_state

        # LEDS = %i{yellow red green}
        LED_CHAR = '◼︎'.freeze
        EMPTY_STRING = "".freeze
        # LED_MAP = LEDS.map { |s| s => LED_CHAR }.freeze

        def initialize(id, props)
          super(id, props)

          # @argument_map = map_arguments(@arguments)
          # @led_state = parse_led_state(@argument_map[:state])
          # LOGGER.unknown(props.keys)
          # @led_state =
        end

        # ---- Printable ---- #

        def bytes
          # { state: @argument_map[:state] }
          { state: nil }
        end

        # ---- Core ---- #

        # @override
        def to_s
          str_buffer = "#{sn}\t#{pretty_leds}"
          str_buffer
        end

        private

        def pretty_leds
          LOGGER.unknown(PROC) { instance_variables }
          LOGGER.unknown(PROC) { instance_variable_get(:@leds) }
          LOGGER.unknown(PROC) { public_methods(false) }

          @pretty_leds ||= parse_led_state(ByteBasic.new(@leds.value, :integer))
        end

        # def map_arguments(arguments)
        #   { state: arguments[0] }
        # end

        # @return String "◼︎ ◼︎ ◼︎"
        def parse_led_state(state_byte)
          state_key = state_byte.d
          state_map = lookup_state_map(state_key)
          led_states = parse_state_map(state_map)
          led_states.join(' ')
        end

        def lookup_state_map(index)
          raise StandardError unless @state.key?(index)
          @state[index]
        end

        def parse_state_map(state_map)
          LOGGER.debug(state_map)
          result = []
          state_map.each_with_index do |v, i|
            LOGGER.debug("LED: Index = #{i}, Value = #{v}")
            string_buffer = '◼︎'
            string_buffer = string_buffer.prepend(led_type(v))
            string_buffer = string_buffer.prepend(led_colour(i))
            string_buffer = string_buffer.concat(close_colour_and_type)
            LOGGER.debug(string_buffer.inspect)
            LOGGER.debug(string_buffer)
            result << string_buffer
          end
          result
        end

        def led_type(index)
          value_key = @value_map[index]
          type_key = @value_to_type_map[value_key]
          LOGGER.debug("Type: #{index} = #{value_key} = #{type_key}")
          return EMPTY_STRING if value_key == :on
          "\33[#{type_key}m"
        end

        def led_colour(index)
          index_key = @index_map[index]
          colour_key = @index_to_colour_map[index_key]
          LOGGER.debug("Colour: #{index} = #{index_key} = #{colour_key}")
          "\33[#{colour_key}m"
        end

        def close_colour_and_type
          "\33[0m"
        end
      end
    end
  end
end
