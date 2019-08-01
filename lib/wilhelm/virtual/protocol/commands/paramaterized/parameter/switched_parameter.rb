# frozen_string_literal: true

module Wilhelm
  module Virtual
    # This needs the :state and :label property of this specific parameter
    class SwitchedParameter < BaseParameter
      PROC = 'SwitchedParameter'

      STATES_HIDDEN = %i[ok off closed].freeze

      WARN_NO_PRETTY_MAP = 'Map @states is no available!'
      ERROR_NIL_SWITCH_STATE = 'Switch State Map returned nil!'

      SWITCH_OFF      = 'OFF'
      SWITCH_ON       = 'ON'

      SWITCH_CLOSED   = 'CLOSED'
      SWITCH_OPEN     = 'OPEN'

      SWITCH_OK       = 'OK'
      SWITCH_FAULT    = 'FAULT'

      SWITCH_PRESS    = 'Press'
      SWITCH_HOLD     = 'Hold'
      SWITCH_RELEASE  = 'Release'

      SWITCH_ENABLED  = 'Enabled'
      SWITCH_DISABLED = 'Disabled'

      SWITCH_BLINK    = 'Blink'
      SWITCH_SINGLE   = 'Single'
      SWITCH_DOUBLE   = 'Double'
      SWITCH_TONE     = 'Tone'

      SWITCH_STATE_MAP = {
        off:       [:as_normal, SWITCH_OFF],
        on:        [:as_good, SWITCH_ON],
        closed:    [:as_normal, SWITCH_CLOSED],
        open:      [:as_warn, SWITCH_OPEN],
        ok:        [:as_good, SWITCH_OK],
        fault:     [:as_bad, SWITCH_FAULT],
        unpowered: [:as_warn, SWITCH_OFF],
        powered:   [:as_good, SWITCH_ON],
        press:     [:as_good, SWITCH_PRESS],
        hold:      [:as_good, SWITCH_HOLD],
        release:   [:as_good, SWITCH_RELEASE],
        disabled:  [:as_good, SWITCH_DISABLED],
        enabled:   [:as_good, SWITCH_ENABLED],
        blink:     [:as_warn, SWITCH_BLINK],
        single:    [:as_warn, SWITCH_SINGLE],
        double:    [:as_warn, SWITCH_DOUBLE],
        tone:      [:as_warn, SWITCH_TONE]
      }.freeze

      LIGHT_GREEN = 92
      COLOUR_RESET = 3

      attr_reader :label, :states

      def initialize(_configuration, integer)
        @value = integer
        @bit_array = BitArray.from_i(integer)
      end

      def inspect
        "<#{PROC} @label=#{label} @value=#{value} @state=#{state}>"
      end

      def hidden_state?(state)
        STATES_HIDDEN.include?(state)
      end

      # @overide
      def to_s(width = DEFAULT_LABEL_WIDTH)
        return nil if hidden_state?(state)
        str_buffer = format("%-#{width}s", label)
        str_buffer.concat(LABEL_DELIMITER)
        str_buffer.concat("[#{pretty}]")
      end

      def state
        if @states.nil?
          LOGGER.warn(PROC) { WARN_NO_PRETTY_MAP }
          return "\"#{value}\""
        end
        @states.fetch(value, "#{d2h(value, true)} not found!")
      end

      # No output: [:off, :on, :ok]
      def pretty
        switch_state = SWITCH_STATE_MAP.fetch(state)
        raise(IndexError, ERROR_NIL_SWITCH_STATE) unless switch_state
        public_send(*switch_state)
      end

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
        "\33[#{colour_id}m" \
        "#{string}" \
        "\33[0m"
      end
    end
  end
end
