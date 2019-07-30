# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        class Augmented < Device::Augmented
          module State
            # Radio related command constants
            module Constants
              UNKNOWN = :unknown
              ON = :on
              OFF = :off

              GFX = :gfx

              ZERO = 0

              INPUT_TIMEOUT = 30

              # SRC-GFX 0x4F --------------------------------------------------
              MONITOR_ON  = 0x00
              MONITOR_OFF = 0x10

              # MENU-GFX 0x45 -------------------------------------------------
              HIDE_RADIO = 0b0000_0001
              HIDE_PANEL = 0b0000_0010
              HIDE_SELECT = 0b0000_0100
              HIDE_EQ = 0b0000_0100
              HIDE_BODY = 0b0000_1100
              HIDE_ALL = 0b0000_1110

              LEFT_INPUT = (0x01..0x08)
              RIGHT_INPUT = (0x81..0x88)

              # TXT-RAD 0x23 --------------------------------------------------
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

              MENU_BASIC     = 0x60
              MENU_TITLED    = 0x61
              HEADER_DIGITAL = 0x62
              MENU_STATIC    = 0x63

              # @note technically don't include 0x62, but Range FTW
              RADIO_LAYOUTS = (0x60..0x63)

              # RAD_ALT 0x37 --------------------------------------------------
              SELECT = (0x40..0x70)
              TONE = (0x80..0xff)

              # OBC-BOOL 0x41 -------------------------------------------------
              OUTSIDE_TEMP = 0x03
              ECON_1       = 0x04
              ECON_2       = 0x05
              RANGE        = 0x06
              SPEED_LIMIT  = 0x09
              AVG_SPEED    = 0x0a
              STOPWATCH    = 0x0e
              OBC_PARAMS = [
                OUTSIDE_TEMP,
                ECON_1,
                ECON_2,
                RANGE,
                SPEED_LIMIT,
                AVG_SPEED,
                STOPWATCH
              ].freeze
            end
          end
        end
      end
    end
  end
end
