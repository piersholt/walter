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
              # OBC Fields
              OBC_OUTSIDE_TEMP = 0x03
              OBC_ECON_1       = 0x04
              OBC_ECON_2       = 0x05
              OBC_RANGE        = 0x06
              OBC_SPEED_LIMIT  = 0x09
              OBC_AVG_SPEED    = 0x0a
              OBC_TIMER        = 0x0e
              OBC_TIMER_LAP    = 0x1a
              # Aux. Heating/Vent. Fields
              AUX_TIMER_1  = 0x0f
              AUX_TIMER_2  = 0x10
              AUX_HEAT_OFF = 0x11
              AUX_HEAT_ON  = 0x12
              AUX_VENT_OFF = 0x13
              AUX_VENT_ON  = 0x14
              # Settings Fields
              SET_TIME     = 0x01
              SET_DATE     = 0x02
              SET_MEMO     = 0x0c
              # Code
              CODE_INPUT   = 0x0d

              OBC_FIELDS = [
                OBC_OUTSIDE_TEMP,
                OBC_ECON_1,
                OBC_ECON_2,
                OBC_RANGE,
                OBC_SPEED_LIMIT,
                OBC_AVG_SPEED,
                OBC_TIMER,
                OBC_TIMER_LAP
              ].freeze

              AUX_FIELDS = [
                AUX_TIMER_1,
                AUX_TIMER_2,
                AUX_HEAT_OFF,
                AUX_HEAT_ON,
                AUX_VENT_OFF,
                AUX_VENT_ON
              ].freeze

              SET_FIELDS = [
                SET_TIME,
                SET_DATE,
                SET_MEMO
              ].freeze

              CODE_FIELDS = [
                CODE_INPUT
              ].freeze

              REQUESTED_FIELDS = [
                *OBC_FIELDS,
                *AUX_FIELDS,
                *SET_FIELDS,
                *CODE_FIELDS
              ].freeze
            end
          end
        end
      end
    end
  end
end
