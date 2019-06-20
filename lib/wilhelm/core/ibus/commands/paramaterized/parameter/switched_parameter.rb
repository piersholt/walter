# frozen_string_literal: false

module Wilhelm
  module Core
    # This needs the :state and :label property of this specific parameter
    class SwitchedParameter < BaseParameter
      PROC = 'SwitchedParameter'.freeze

      attr_reader :label, :states, :state

      # @@label
      # @@states

      def initialize(configuration, integer)
        @value = integer
        @bit_array = BitArray.from_i(integer)
        # @label = 'Something Important'
        # @state = :ok
      end

      def inspect
        "<#{PROC} @label=#{label} @value=#{value} @state=#{state}>"
      end

      # @overide
      def to_s(width = DEFAULT_LABEL_WIDTH)
        return nil if [:ok, :off, :closed].include?(state)
        # LOGGER.info(PROC) { "#to_s(width = #{width})" }
        str_buffer = format("%-#{width}s", "#{label}")
        str_buffer = str_buffer.concat(LABEL_DELIMITER)
        str_buffer = str_buffer.concat("[#{pretty}]")
        str_buffer
      end

      def state
        if @states.nil?
          LOGGER.warn(PROC) { "Map @states is no available!" }
          return "\"value\""
        elsif !@states.key?(value)
          return "#{d2h(value, true)} not found!"
        else
          @states[value]
        end
      end

      # No output: [:off, :on, :ok]
      def pretty
        case state
        when :off
          as_normal('OFF')
        when :on
          as_good('ON')
        when :closed
          as_normal('OFF')
        when :open
          as_warn('OPEN')
        when :ok
          as_good('OK')
        when :fault
          as_bad('FAULT')
        when :unpowered
          as_warn('OFF')
        when :powered
          as_good('ON')
        when :press
          as_good('Press')
        when :hold
          as_good('Hold')
        when :release
          as_good('Release')
        when :enabled
          as_good('Enabled')
        when :disabled
          as_good('Disabled')
        end
      end

      LIGHT_GREEN = 92
      COLOUR_RESET = 3

      def as_bad(bit)
        as_colour(bit, LogActually::Constants::RED)
      end

      def as_warn(bit)
        as_colour(bit, LogActually::Constants::YELLOW)
      end

      def as_good(bit)
        as_colour(bit, LIGHT_GREEN)
      end

      def as_normal(bit)
        as_colour(bit, COLOUR_RESET)
      end

      def as_colour(string, colour_id)
        str_buffer = "\33[#{colour_id}m"
        str_buffer = str_buffer.concat("#{string}")
        str_buffer = str_buffer.concat("\33[0m")
        str_buffer
      end
    end
  end
end
