# frozen_string_literal: true

module Wilhelm
  module Virtual
    # This needs the :state and :label property of this specific parameter
    class SwitchedParameter < BaseParameter
      PROC = 'SwitchedParameter'

      STATES_HIDDEN = %i[ok off closed].freeze

      WARN_NO_PRETTY_MAP = '@states is no defined!'
      ERROR_NIL_SWITCH_STATE = '@states does not have key!'

      SWITCH_OFF      = 'OFF'
      SWITCH_ON       = 'ON'

      SWITCH_CLOSED   = 'CLOSED'
      SWITCH_OPEN     = 'OPEN'

      SWITCH_OK       = 'OK'
      SWITCH_WARN     = 'WARN'
      SWITCH_FAULT    = 'FAULT'

      SWITCH_PRESS    = 'Press'
      SWITCH_HOLD     = 'Hold'
      SWITCH_RELEASE  = 'Release'

      SWITCH_ENABLED  = 'Enabled'
      SWITCH_DISABLED = 'Disabled'

      # Monitor
      SWITCH_NAV      = 'Nav. GT'
      SWITCH_TV       = 'Vid. TV'
      SWITCH_VIDEO    = 'Vid. GT'

      SWITCH_NTSC     = 'NTSC'
      SWITCH_PAL      = 'PAL'

      SWITCH_4_3      = '4:3'
      SWITCH_16_9     = '16:9'
      SWITCH_ZOOM     = 'Zoom'

      # HUD Chevron
      SWITCH_BLINK    = 'Blink'

      # HUD Gong
      SWITCH_HIGH_SINGLE = 'High Single'
      SWITCH_HIGH_TONE   = 'High Continuous'
      SWITCH_HIGH_DOUBLE = 'High Double'
      SWITCH_LOW_SINGLE  = 'Low Single'

      SWITCH_INACTIVE = 'OFF'

      # IKE Region
      SWITCH_DE       = 'DE'
      SWITCH_GB       = 'GB'
      SWITCH_US       = 'US'
      SWITCH_IT       = 'IT'
      SWITCH_ES       = 'ES'
      SWITCH_JP       = 'JP'
      SWITCH_FR       = 'FR'
      SWITCH_CA       = 'CA'
      SWITCH_AR       = 'AR'

      SWITCH_24H      = '24H'
      SWITCH_12H      = '12H'

      SWITCH_KM       = 'KM'
      SWITCH_MLS      = 'MLS'

      SWITCH_L_100    = 'l/100km'
      SWITCH_MPG_UK   = 'mpg UK'
      SWITCH_MPG_US   = 'mpg US'
      SWITCH_KM_L     = 'km/l'

      SWITCH_C        = "\u00b0C"
      SWITCH_F        = "\u00b0F"

      SWITCH_STATE_MAP = {
        off:          [:as_normal, SWITCH_OFF],
        on:           [:as_green,  SWITCH_ON],
        closed:       [:as_normal, SWITCH_CLOSED],
        open:         [:as_yellow, SWITCH_OPEN],
        ok:           [:as_green,  SWITCH_OK],
        warn:         [:as_yellow, SWITCH_WARN],
        fault:        [:as_red,    SWITCH_FAULT],
        unpowered:    [:as_yellow, SWITCH_OFF],
        powered:      [:as_green,  SWITCH_ON],
        press:        [:as_green,  SWITCH_PRESS],
        hold:         [:as_green,  SWITCH_HOLD],
        release:      [:as_green,  SWITCH_RELEASE],
        disabled:     [:as_green,  SWITCH_DISABLED],
        enabled:      [:as_green,  SWITCH_ENABLED],
        blink:        [:as_yellow, SWITCH_BLINK],
        high_single:  [:as_yellow, SWITCH_HIGH_SINGLE],
        high_tone:    [:as_yellow, SWITCH_HIGH_TONE],
        high_double:  [:as_yellow, SWITCH_HIGH_DOUBLE],
        low_single:   [:as_yellow, SWITCH_LOW_SINGLE],
        inactive:     [:as_blue,   SWITCH_INACTIVE],
        nav:          [:as_green,  SWITCH_NAV],
        tv:           [:as_yellow, SWITCH_TV],
        video:        [:as_yellow, SWITCH_VIDEO],
        standard:     [:as_yellow, SWITCH_4_3],
        wide:         [:as_green,  SWITCH_16_9],
        zoom:         [:as_yellow, SWITCH_ZOOM],
        ntsc:         [:as_green,  SWITCH_NTSC],
        pal:          [:as_green,  SWITCH_PAL],
        de:           [:as_green, SWITCH_DE],
        gb:           [:as_green, SWITCH_GB],
        us:           [:as_green, SWITCH_US],
        it:           [:as_green, SWITCH_IT],
        es:           [:as_green, SWITCH_ES],
        jp:           [:as_green, SWITCH_JP],
        fr:           [:as_green, SWITCH_FR],
        ca:           [:as_green, SWITCH_CA],
        ar:           [:as_green, SWITCH_AR],
        h24:          [:as_green, SWITCH_24H],
        h12:          [:as_green, SWITCH_12H],
        km:           [:as_green, SWITCH_KM],
        mls:          [:as_green, SWITCH_MLS],
        celsius:      [:as_green, SWITCH_C],
        fahrenheit:   [:as_green, SWITCH_F],
        l_100:        [:as_green, SWITCH_L_100],
        mpg_uk:       [:as_green, SWITCH_MPG_UK],
        mpg_us:       [:as_green, SWITCH_MPG_US],
        km_l:         [:as_green, SWITCH_KM_L]
      }.freeze

      LIGHT_GREEN  = 92
      BLUE         = 34
      COLOUR_RESET = 3

      attr_reader :label, :states
      alias map states

      def initialize(_configuration, integer)
        @value = integer
        @bit_array = Core::BitArray.from_i(integer)
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
        return "[#{pretty}]" unless label
        str_buffer = format("%-#{width}s", label) if label
        str_buffer.concat(LABEL_DELIMITER) if label
        str_buffer.concat("[#{pretty}]")
      end

      def state
        if @states.nil?
          LOGGER.warn(PROC) { WARN_NO_PRETTY_MAP }
          return "\"#{value}\""
        end
        @states.fetch(value, "#{d2h(value, true)} not found!")
      end

      alias ugly state

      # No output: [:off, :on, :ok]
      def pretty
        switch_state = SWITCH_STATE_MAP.fetch(state, nil)
        raise(IndexError, ERROR_NIL_SWITCH_STATE) unless switch_state
        public_send(*switch_state)
      end

      def as_red(bit)
        as_colour(bit, LogActually::Constants::RED)
      end

      alias as_bad as_red

      def as_yellow(bit)
        as_colour(bit, LogActually::Constants::YELLOW)
      end

      alias as_warn as_yellow

      def as_green(bit)
        as_colour(bit, LIGHT_GREEN)
      end

      alias as_good as_green

      def as_normal(bit)
        as_colour(bit, COLOUR_RESET)
      end

      def as_blue(bit)
        as_colour(bit, BLUE)
      end

      def as_colour(string, colour_id)
        "\33[#{colour_id}m" \
        "#{string}" \
        "\33[0m"
      end
    end
  end
end
