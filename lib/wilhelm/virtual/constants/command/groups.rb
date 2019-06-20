# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Command
        # Comment
        module Groups
          include Aliases

          READY = [PING, PONG].freeze

          SPEED = [SPEED_STATUS].freeze
          TEMPERATURE = [TEMP_REQ, TEMP_REP].freeze
          IGNITION = [IGNITION_REQ, IGNITION_REP].freeze
          SENSORS = [SENSORS_REQ, SENSORS_REP].freeze
          COUNTRY = [COUNTRY_REQ, COUNTRY_REP].freeze
          ODOMETER = [ODO_REQ, ODO_REP].freeze
          VEHICLE = [VEH_REQ, VEH_REP].freeze
          LAMP = [LAMP_REQ, LAMP_REP].freeze
          DOOR = [DOOR_REQ, DOOR_REP].freeze

          OBC = [OBC_CTL, OBC_CONFIG, OBC_REQ].freeze

          DISPLAY = [TXT_MID, TXT_GFX, TXT_HUD, TXT_NAV, GFX_STATUS].freeze

          NAVIGATION = [COORDINATES, ADDRESS, REAR, CELL, UTC].freeze

          MENUS = [MENU_GFX, MENU_RAD].freeze

          MID = [TXT_MID, GFX_STATUS].freeze

          MFL = [MFL_VOL, MFL_FUNC].freeze
          BMBT = [BMBT_I, BMBT_A, BMBT_B].freeze

          BUTTON = MFL + BMBT

          TELEPHONE = [TEL_LED, TEL_STATE, TEL_DATA].freeze
          CD_CHANGER = [CDC_REQ, CDC_REP].freeze

          DIAGNOSTICS = [
            DIA_HELLO,
            DIA_ERR_READ,
            DIA_ERR_DEL,
            DIA_COD_READ,
            DIA_STATUS,
            DIA_VEH_CTRL,
            SLF_CHK,
            EHC_DIG,
            EWS_ISN,
            EWS_INT,
            EWS_COD,
            EWS_KEY,
            DIA_TRANS,
            EWS_X,
            EWS_END,
            DIA_DATA,
            DIA_MEM_READ,
            DIA_MEM_WRITE,
            DIA_COD_WRITE
          ].freeze

          NOISEY_NG = {
            ready: READY,
            speed: SPEED,
            temperature: TEMPERATURE,
            ignition: IGNITION,
            sensors: SENSORS,
            country: COUNTRY,
            odometer: ODOMETER,
            vehicle: VEHICLE,
            lamp: LAMP,
            door: DOOR,
            navigation: NAVIGATION,
            cdc: CD_CHANGER
          }.freeze

          NOISEY = {
            ready: READY,
            speed: SPEED,
            temperature: TEMPERATURE,
            ignition: IGNITION,
            sensors: SENSORS,
            country: COUNTRY,
            odometer: ODOMETER,
            vehicle: VEHICLE,
            lamp: LAMP,
            door: DOOR,
            navigation: NAVIGATION
          }.freeze

          # NOISE = NOISEY_NG
          #
          # NOISEY =
          #   NOISE[:ready] + NOISE[:speed] + NOISE[:temperature] + NOISE[:ignition] +
          #   NOISE[:sensors] + NOISE[:country] + NOISE[:odometer] +
          #   NOISE[:vehicle] + NOISE[:lamp] + NOISE[:door]
        end
      end
    end
  end
end

module Wilhelm
  module Core
  end
end
class Command
end
