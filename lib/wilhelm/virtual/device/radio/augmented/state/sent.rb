# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          module State
            # Device::Radio::Augmented::State::Sent
            module Sent
              include Constants

              def evaluate_menu_rad(command)
                case command.state.value
                when MAIN_MENU
                  background
                when HIDE_HEADER
                  background
                when HIDE_SELECT
                  body_select!
                when HIDE_TONE
                  body_eq!
                when HIDE_MENU
                  body_cleared
                when (HIDE_HEADER..0b0000_1111)
                  body_cleared
                end
              end

              def evaluate_display_layout(command)
                case command.gt.value
                when RADIO_LAYOUTS
                  radio
                  radio_layout
                when RDS_LAYOUTS
                  digital_layout
                when TAPE_LAYOUTS
                  tape
                  tape_layout
                when CDC_LAYOUTS
                  cdc
                  cdc_layout
                end
              end

              def evaluate_nav_layout(command)
                case command.layout.value
                when RADIO_LEDS
                  radio
                  radio_layout
                when RDS_LEDS
                  digital_layout
                when TAPE_LEDS
                  tape
                  tape_layout
                when CDC_LEDS
                  cdc
                  cdc_layout
                end
              end

              def evaluate_radio_led(command)
                case command.led.value
                when RAD_LED_OFF
                  off
                when RAD_LED_RESET
                  # off
                when RAD_LED_ON
                  on
                when RAD_LED_RADIO
                  radio
                  on
                when (0x41..0x45)
                  # tape
                  # on
                when (0x5a..0x5e)
                  # tape
                  # on
                when 0x5f
                  logger.info(self.class) { "Radio LED 0x5f?" }
                else
                  logger.warn(self.class) { "Unknown RAD-LED value: #{command.led.value}" }
                end
              end

              def evaluate_radio_alt(command)
                case command.mode.value
                when (0x40..0x70)
                  body_select
                when (0x80..0xff)
                  body_eq
                else
                  logger.warn(self.class) { "Unknown RAD-ALT value: #{command.mode.value}" }
                end
              end

              def evaluate_cdc_request(command)
                case command.control?
                when :status
                  # ignore
                else
                  cdc
                end
              end
            end
          end
        end
      end
    end
  end
end
