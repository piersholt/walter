# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        class Augmented < Device::Augmented
          module State
            # Radio related command constants
            module Constants
              include Virtual::Constants::Events::Display

              UNKNOWN = :unknown
              ON = :on
              OFF = :off

              GFX = :gfx

              ZERO = 0

              INPUT_TIMEOUT = 30

              # BUTTON STATES ------------------------------------------------

              CONFIRM_PRESS = 0x05
              CONFIRM_HOLD = 0x45
              CONFIRM_RELEASE = 0x85

              MENU_PRESS = 0x34
              MENU_HOLD = 0x74
              MENU_RELEASE = 0xB4

              HIDE_RADIO = 0b0000_0001
              HIDE_PANEL = 0b0000_0010
              HIDE_SELECT = 0b0000_0100
              HIDE_EQ = 0b0000_0100
              HIDE_BODY = 0b0000_1100
              HIDE_ALL = 0b0000_1110

              LEFT_INPUT = (0x01..0x08)
              RIGHT_INPUT = (0x81..0x88)

              # RENDERING ------------------------------------------------

              HEADER = {
                service: (0x00..0x1f),
                weather_band: (0x20..0x3f),
                radio: (0x40..0x5f),
                digital: (0x60..0x7f),
                tape: (0x80..0x9f),
                traffic: (0xa0..0xbf),
                cdc: (0xc0..0xdf)
              }.freeze

              HEADERS_VALID = %i[
                service weather_band radio
                digital tape traffic cdc unknown
              ].freeze

              MENUS_VALID = %i[basic titled static].freeze

              MENU_BASIC = 0x60
              MENU_TITLED = 0x61
              HEADER_DIGITAL = 0x62
              MENU_STATIC = 0x63

              RADIO_ALT = 0x37

              SELECT = (0x40..0x70)
              TONE = (0x80..0xff)

              # Command 0x41 OBC-REQ Parameters
              OUTSIDE_TEMP = 0x03
              ECON_1 = 0x04
              ECON_2 = 0x05
              RANGE = 0x06
              SPEED_LIMIT = 0x09
              AVG_SPEED = 0x0a
              STOPWATCH = 0x0e
              OBC_PARAMS = [OUTSIDE_TEMP, ECON_1, ECON_2, RANGE, SPEED_LIMIT, AVG_SPEED, STOPWATCH]
            end
          end
        end
      end
    end
  end
end
