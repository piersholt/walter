# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        class Augmented < Device::Augmented
          module State
            # Comment
            module Received
              include Virtual::Constants::Events
              include Constants
              def nested
                Module.nesting
              end

              # RENDERING -------------------------------------------------

              def handle_draw_23(command)
                case command.gfx.value
                when HEADER[:service]
                  layout = :digital
                  # radio_header(:service)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_SERVICE, source: ident)
                when HEADER[:weather_band]
                  layout = :weather_band
                  # radio_header(:weather_band)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_WEATHER_BAND, source: ident)
                when HEADER[:radio]
                  layout = :radio
                  # radio_header(:radio)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_RADIO, source: ident)
                when HEADER[:digital]
                  layout = :digital
                  # radio_header(:digital)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_DIGITAL, source: ident)
                when HEADER[:tape]
                  layout = :tape
                  # radio_header(:tape)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_TAPE, source: ident)
                when HEADER[:traffic]
                  layout = :traffic
                  # radio_header(:traffic)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_TRAFFIC, source: ident)
                when HEADER[:cdc]
                  layout = :cdc
                  # radio_header(:cdc)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_CDC, source: ident)
                when HEADER[:unknown]
                  # radio_header(:unknown)
                  # radio_display_on
                  # changed
                  # notify_observers(RADIO_LAYOUT_UNKNOWN, source: ident)
                  layout = :unknown
                else
                  layout = false
                end

                return unless layout

                changed
                notify_observers(HEADER_WRITE, layout: layout, index: 0, chars: command.chars.value)
              end

              def handle_draw_a5(command)
                layout = command.layout.value
                zone = command.zone.parameters[:zone].value
                case layout
                when MENU_BASIC
                  event = zone.zero? ? MENU_WRITE : MENU_CACHE
                  layout = :basic
                when MENU_TITLED
                  event = zone.zero? ? MENU_WRITE : MENU_CACHE
                  layout = :titled
                when HEADER_DIGITAL
                  event = zone.zero? ? HEADER_WRITE : HEADER_CACHE
                  layout = :digital
                when MENU_STATIC
                  event = zone.zero? ? MENU_WRITE : MENU_CACHE
                  layout = :static
                else
                  LOGGER.warn('AugmentedGFX') { 'No 0xA5 write event...?' }
                  event = false
                end

                return unless event

                changed
                notify_observers(event, layout: layout, index: zone, chars: command.chars.value)
              end

              def handle_draw_21(command)
                layout = command.m1.value
                zone = command.m3.parameters[:index].value
                case layout
                when MENU_BASIC
                  event = MENU_CACHE
                  layout = :basic
                when MENU_TITLED
                  event = MENU_CACHE
                  layout = :titled
                when HEADER_DIGITAL
                  event = HEADER_CACHE
                  layout = :digital
                when MENU_STATIC
                  event = MENU_CACHE
                  layout = :static
                else
                  LOGGER.warn('AugmentedGFX') { 'No 0x21 write event...?' }
                  event = false
                end

                return unless event

                changed
                notify_observers(event, layout: layout, index: zone, chars: command.chars.value)
              end

              # MENUS -------------------------------------------------

              def handle_menu_rad(command)
                case command.state.value
                when HIDE_RADIO
                  # priority_gfx
                  # radio_display_off
                when HIDE_PANEL
                  # priority_gfx
                  # radio_display_off
                when HIDE_EQ
                  # priority_radio
                  # radio_display_on
                  # radio_body(:off)
                when HIDE_SELECT
                  # priority_radio
                  # radio_display_on
                  # radio_body(:off)
                when HIDE_BODY
                  # priority_radio
                  # radio_display_on
                  # radio_body(:off)
                when HIDE_ALL
                  # priority_gfx
                  # radio_display_off
                  # radio_body(:off)
                when (0b0000_0010..0b0000_1110)
                  # priority_radio
                  # radio_hide_select
                  # radio_hide_eq
                end
              end

              def handle_radio_alt(command)
                case command.mode.value
                when SELECT
                  # radio_body(:select)
                when TONE
                  # radio_body(:eq)
                end
              end
            end
          end
        end
      end
    end
  end
end
