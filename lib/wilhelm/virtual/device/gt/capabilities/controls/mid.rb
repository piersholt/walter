# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          module Controls
            # GT::Capabilities::Controls::MID
            module MID
              LAYOUT_RADIO_PRESETS  = 0x41
              LAYOUT_RADIO_SOURCE   = 0x43
              LAYOUT_CDC_DISCS      = 0xc0
              LAYOUT_CDC_SOURCE     = 0xc0

              FUNCTION_DEFAULT      = 0x00

              STATE_PRESS           = 0x00
              STATE_HOLD            = 0x20
              STATE_RELEASE         = 0x40

              # Radio Presets   " 1 ☐ 2 ☐ 3 ☐ 4 ☐ 5 ☐ 6 "
              # Radio Presets   " A1☐A2*☐ A3☐A4 ☐ A5☐A6 "
              # Radio Source    "FM☐AM☐SC☐CD☐TAPE☐   "
              ID_RADIO_PRESET_1     = 0x00
              ID_RADIO_PRESET_2     = 0x01
              ID_RADIO_PRESET_3     = 0x02
              ID_RADIO_PRESET_4     = 0x03
              ID_RADIO_PRESET_5     = 0x04
              ID_RADIO_PRESET_6     = 0x05
              ID_RADIO_FM           = 0x06
              ID_RADIO_AM           = 0x07
              ID_RADIO_SCAN         = 0x08
              ID_RADIO_CD           = 0x09
              ID_RADIO_TAPE         = 0x0a
              ID_RADIO_EMPTY        = 0x0b

              # CDC Discs       " 1☐  ☐  ☐  ☐  ☐  "
              # CDC Source      "FM☐AM☐SC☐RND☐TAPE☐    "
              ID_CDC_DISC_1         = 0x00
              ID_CDC_DISC_2         = 0x01
              ID_CDC_DISC_3         = 0x02
              ID_CDC_DISC_4         = 0x03
              ID_CDC_DISC_5         = 0x04
              ID_CDC_DISC_6         = 0x05
              ID_CDC_FM             = 0x06
              ID_CDC_AM             = 0x07
              ID_CDC_SCAN           = 0x08
              ID_CDC_RND            = 0x09
              ID_CDC_TAPE           = 0x0a
              ID_CDC_EMPTY          = 0x0b

              # Presets

              def p1!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_1
                )
              end

              def p2!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_2
                )
              end

              def p3!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_3
                )
              end

              def p4!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_4
                )
              end

              def p5!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_5
                )
              end

              def p6!
                simulate_soft_input(
                  LAYOUT_RADIO_PRESETS,
                  FUNCTION_DEFAULT,
                  ID_RADIO_PRESET_6
                )
              end

              # Source

              def fm!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_FM
                )
              end

              def am!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_AM
                )
              end

              def scan!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_SCAN
                )
              end

              def cd!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_CD
                )
              end

              def tape!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_TAPE
                )
              end

              def empty!
                simulate_soft_input(
                  LAYOUT_RADIO_SOURCE,
                  FUNCTION_DEFAULT,
                  ID_RADIO_EMPTY
                )
              end
            end
          end
        end
      end
    end
  end
end
