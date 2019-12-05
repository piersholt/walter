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
                when 0b0000_0001
                  background
                when 0b0000_0010
                  background
                when 0b0000_0100
                  body_select!
                when 0b0000_1000
                  body_eq!
                when 0b0000_1100
                  body_cleared
                when (0b0000_0010..0b0000_1111)
                  body_cleared
                end
              end

              def evaluate_display_layout(command)
                case command.gt.value
                when (0x40..0x5F)
                  radio
                  radio_layout
                when (0x60..0x7F)
                  digital_layout
                when (0x80..0x9F)
                  tape
                  tape_layout
                when (0xc0..0xcF)
                  cdc
                  cdc_layout
                end
              end

              RADIO_LAYOUTS = (0x40..0x5F)
              RDS_LAYOUTS = (0x60..0x7F)
              TAPE_LAYOUTS = (0x80..0x9F)
              CDC_LAYOUTS = (0xc0..0xcF)

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

              RAD_LED_RESET = 0x90

              def evaluate_radio_led(command)
                case command.led.value
                when 0x00
                  off
                when RAD_LED_RESET
                  # off
                when 0xFF
                  on
                when 0x48
                  radio
                  on
                when (0x41..0x45)
                  # tape
                  # on
                when (0x5a..0x5e)
                  # tape
                  # on
                when 95
                  logger.info(self.class) { "Radio LED 95?" }
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
