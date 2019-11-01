# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        class Augmented < Device::Augmented
          module State
            # Device::GT
            module Received
              include Virtual::Constants::Events
              include Constants
              def nested
                Module.nesting
              end

              # RENDERING -------------------------------------------------

              def handle_draw_23(command)
                return false unless HEADERS[:digital]&.cover?(command.gt.value)

                changed
                notify_observers(
                  HEADER_WRITE,
                  layout: :digital,
                  index: 0,
                  chars: command.chars.value
                )
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
                  event = false
                end

                return unless event

                changed
                notify_observers(
                  event,
                  layout: layout,
                  index: zone,
                  chars: command.chars.value
                )
              end

              def handle_draw_21(command)
                layout = command.layout.value
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
                  event = false
                end

                return unless event

                changed
                notify_observers(
                  event,
                  layout: layout,
                  index: zone,
                  chars: command.chars.value
                )
              end

              # MENUS -------------------------------------------------

              def handle_menu_rad(command)
                case command.state.value
                when HIDE_RADIO
                  # priority_gt
                  # radio_display_off
                when HIDE_PANEL
                  # priority_gt
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
                  # priority_gt
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
