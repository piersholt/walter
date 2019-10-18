# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        class Augmented < Device::Augmented
          module State
            # Radio related command constants
            module Constants
              UNKNOWN = :unknown
              ON = :on
              OFF = :off

              GT  = :gt

              ZERO = 0

              INPUT_TIMEOUT = 30

              # SRC-GT 0x4F --------------------------------------------------
              MONITOR_ON  = 0x00
              MONITOR_OFF = 0x10

              # MENU-GT 0x45 -------------------------------------------------
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

              # OBC-VAR/BOOL FIELDS -------------------------------------------
              # Settings Fields
              SET_TIME         = 0x01
              SET_DATE         = 0x02
              SET_MEMO         = 0x0c
              # OBC Fields
              OBC_OUTSIDE_TEMP = 0x03
              OBC_ECON_1       = 0x04
              OBC_ECON_2       = 0x05
              OBC_RANGE        = 0x06
              OBC_DISTANCE     = 0x07
              OBC_ARRIVAL      = 0x08
              OBC_LIMIT        = 0x09
              OBC_AVG_SPEED    = 0x0a
              OBC_TIMER        = 0x0e
              OBC_TIMER_LAP    = 0x1a
              # Nav? Fields
              NAV_ARRIVAL_TIME = 0x05
              NAV_DIST_TO_DEST = 0x06
              # Code
              CODE_INPUT       = 0x0d
              # Aux. Heating/Vent. Fields
              AUX_TIMER_1      = 0x0f
              AUX_TIMER_2      = 0x10
              AUX_HEAT_OFF     = 0x11
              AUX_HEAT_ON      = 0x12
              AUX_VENT_OFF     = 0x13
              AUX_VENT_ON      = 0x14

              # OBC-VAR 0x40 -------------------------------------------------
              FIELDS_VAR_SETTINGS = [
                SET_TIME,
                SET_DATE
              ].freeze

              FIELDS_VAR_OBC = [
                OBC_DISTANCE,
                OBC_LIMIT
              ].freeze

              FIELDS_VAR_CODE = [
                CODE_INPUT
              ].freeze

              FIELDS_VAR_AUX = [
                AUX_TIMER_1,
                AUX_TIMER_2
              ].freeze

              VARIABLE_FIELDS = [
                *FIELDS_VAR_SETTINGS,
                *FIELDS_VAR_OBC,
                *FIELDS_VAR_CODE,
                *FIELDS_VAR_AUX
              ].freeze

              # OBC-BOOL 0x41 -------------------------------------------------

              FIELDS_BOOL_SETTINGS = [
                SET_TIME,
                SET_DATE,
                SET_MEMO
              ].freeze

              FIELDS_BOOL_OBC = [
                OBC_OUTSIDE_TEMP,
                OBC_ECON_1,
                OBC_ECON_2,
                OBC_RANGE,
                OBC_DISTANCE,
                OBC_ARRIVAL,
                OBC_LIMIT,
                OBC_AVG_SPEED,
                OBC_TIMER,
                OBC_TIMER_LAP
              ].freeze

              FIELDS_BOOL_AUX = [
                AUX_TIMER_1,
                AUX_TIMER_2,
                AUX_HEAT_OFF,
                AUX_HEAT_ON,
                AUX_VENT_OFF,
                AUX_VENT_ON
              ].freeze

              REQUESTED_FIELDS = [
                *FIELDS_BOOL_SETTINGS,
                *FIELDS_BOOL_OBC,
                *FIELDS_BOOL_AUX,
              ].freeze
            end
          end
        end
      end
    end
  end
end
