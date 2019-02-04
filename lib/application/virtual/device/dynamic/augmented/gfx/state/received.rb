# frozen_string_literal: true

class Virtual
  class AugmentedGFX < AugmentedDevice
    module State
      # Comment
      module Received
        include Events
        include Constants

        def handle_bmbt_1_button(command)
          value = command.totally_unique_variable_name

          case value
          when CONFIRM_PRESS
            # logger.debug(moi) { "|-> CONFIRM_PRESS" }
            # changed
            # notify_observers(INPUT_CONFIRM_SELECT, source: ident, offset: value)
          when CONFIRM_HOLD
            # logger.debug(moi) { "|-> CONFIRM_HOLD" }
            # changed
            # notify_observers(INPUT_CONFIRM_HOLD, source: ident)
          when CONFIRM_RELEASE
            # logger.debug(moi) { "|-> CONFIRM_RELEASE" }
            # changed
            # notify_observers(INPUT_CONFIRM_RELEASE, source: ident)
          end
        end

        def handle_bmbt_2_button(command)
          value = command.totally_unique_variable_name

          case value
          when LEFT_1..LEFT_8
            logger.debug(moi) { "LEFT" }
            changed
            notify_observers(INPUT_LEFT, value: value, source: ident)
          when RIGHT_1..RIGHT_8
            logger.debug(moi) { "RIGHT" }
            changed
            notify_observers(INPUT_RIGHT, value: (value - 0x80), source: ident)
          end
        end

        def handle_draw_23(command)
          case command.gfx.value
          when (0x00..0x1f)
            radio_header(:service)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_SERVICE, source: ident)
            # notify_observers(RADIO_WRITE, header: RADIO_LAYOUT_SERVICE, source: ident)
          when (0x20..0x3f)
            radio_header(:weather_band)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_WEATHER_BAND, source: ident)
          when (0x40..0x5f)
            radio_header(:radio)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_RADIO, source: ident)
          when (0x60..0x7f)
            radio_header(:digital)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_DIGITAL, source: ident)
          when (0x80..0x9f)
            radio_header(:tape)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_TAPE, source: ident)
          when (0xa0..0xbf)
            radio_header(:traffic)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_TRAFFIC, source: ident)
          when (0xc0..0xdf)
            radio_header(:cdc)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_CDC, source: ident)
          when (0xe0..0xff)
            radio_header(:unknown)
            radio_display_on
            changed
            notify_observers(RADIO_LAYOUT_UNKNOWN, source: ident)
          end
        end

        def handle_draw_a5(command)
          case command.layout.value
          when 0x60
            radio_body(:menu)
            # radio_display_on
          when 0x61
            radio_body(:menu)
          end
        end

        HIDE_RADIO = 0b0000_0001
        HIDE_PANEL = 0b0000_0010
        HIDE_SELECT = 0b0000_0100
        HIDE_EQ = 0b0000_0100
        HIDE_BODY = 0b0000_1100
        HIDE_ALL = 0b0000_1110

        def handle_menu_rad(command)
          case command.state.value
          when HIDE_RADIO
            priority_gfx
            radio_display_off
          when HIDE_PANEL
            priority_gfx
            radio_display_off
          when HIDE_EQ
            # priority_radio
            # radio_display_on
            radio_body(:off)
          when HIDE_SELECT
            # priority_radio
            # radio_display_on
            # radio_body(:off)
          when HIDE_BODY
            # priority_radio
            # radio_display_on
            # radio_body(:off)
          when HIDE_ALL
            priority_gfx
            radio_display_off
            radio_body(:off)
          when (0b0000_0010..0b0000_1110)
            # priority_radio
            # radio_hide_select
            # radio_hide_eq
          end
        end

        def handle_radio_alt(command)
          case command.mode.value
          when (0x40..0x70)
            radio_body(:select)
          when (0x80..0xff)
            radio_body(:eq)
          end
        end
      end
    end
  end
end
