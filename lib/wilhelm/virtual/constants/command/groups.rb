# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Command
        # Virtual::Constants::Command::Groups
        module Groups
          include Aliases
          # 0x01, 0x02
          READY = [PING, PONG].freeze
          # 0x10, 0x11
          IGNITION    = [IGNITION_REQ, IGNITION_REP].freeze
          # 0x12, 0x13
          SENSORS     = [SENSORS_REQ, SENSORS_REP].freeze
          # 0x14, 0x15
          COUNTRY     = [COUNTRY_REQ, COUNTRY_REP].freeze
          # 0x16, 0x17
          ODOMETER    = [ODO_REQ, ODO_REP].freeze
          # 0x19, 0x1d
          TEMPERATURE = [TEMP_REQ, TEMP_REP].freeze
          # 0x53, 0x54, 0x55
          VEHICLE     = [VEH_LCM_REQ, VEH_LCM, VEH_IKE].freeze
          # 0x5A, 0x5B
          LAMP        = [LAMP_REQ, LAMP_REP].freeze
          # 0x79, 0x7A
          DOOR        = [DOOR_REQ, DOOR_REP].freeze
          # 0x2a, 0x24, 0x40, 0x41
          OBC = [ANZV_BOOL, ANZV_VAR,  OBC_VAR, OBC_BOOL].freeze
          # 0x21 0x23 0x24 0xa5 0x22
          DISPLAY = [TXT_MID, TXT_GT, ANZV_VAR, TXT_NAV, GT_STATUS].freeze
          # 0x1a, 0x51, 0x52, 0x57
          HUD = [TXT_CCM, HUD_STATUS, CCM_END, CCM_RLY].freeze
          # 0x1a, 0x1b, 0x50, 0x51, 0x52, 0x57
          CCM = [
            TXT_CCM, HUD_STATUS,
            CCM_REQ, CCM_END,
            CCM_RLY,
            IKE_BTN
          ].freeze

          # 0x1f 0xa2 0xa4
          GPS = [UTC, COORDINATES, ADDRESS].freeze
          # 0xa9 0xab 0xaf
          NAVIGATION = [GT2, ASSIST].freeze

          # 0x23 0x46
          MENUS = [MENU_GT, MENU_RAD].freeze
          # 0x21 0x22
          MID = [TXT_MID, GT_STATUS].freeze

          # 0x32 0x3b
          MFL  = [MFL_VOL, MFL_FUNC].freeze
          # 0x47 0x48 0x49
          BMBT = [BMBT_I, BMBT_A, BMBT_B].freeze
          # 0x32 0x49
          VOLUME = [MFL_VOL, BMBT_B].freeze
          BUTTON = [INPUT, *MFL, *BMBT].freeze

          # 0x20, 0x2b, 0x2c, 0x31, 0x21, 0x23, 0x24
          TELEPHONE = [
            TEL_OPEN, TEL_LED, TEL_STATE, INPUT, TXT_MID, TXT_GT, ANZV_VAR
          ].freeze

          KEYLESS = [
            REMOTE, VIS_ACK, DOOR_REP
          ].freeze

          # 0x38 0x39
          CD_CHANGER = [CDC_REQ, CDC_REP].freeze

          UI = [
            # IGNITION_REP,
            MENU_GT, MENU_RAD,
            RAD_LED,
            # BMBT_I, BMBT_A,
            # RAD_EQ, RAD_ALT,
            RAD_ALT,
            TXT_MID, TXT_GT, TXT_NAV,
            DSP_SET, DSP_REP
          ].freeze

          DIAGNOSTICS = [
            0x00,
            0x04, 0x05,
            0x06, 0x07,
            0x08, 0x09,
            0x0b,
            0x0c,
            0x30, 0x3f,
            0x60, 0x61, 0x65, 0x69, 0x6b,
            0x9c, 0x9d, 0x9e, 0x9f,
            0xa0, 0xa1,
            0xb0, 0xb1
          ].freeze

          NOISEY_NG = {
            ready: READY,
            speed: [SPEED],
            temperature: TEMPERATURE,
            ignition: IGNITION,
            sensors: SENSORS,
            country: COUNTRY,
            odometer: ODOMETER,
            vehicle: VEHICLE,
            lamp: LAMP,
            door: DOOR,
            navigation: NAVIGATION,
            gps: GPS,
            cdc: CD_CHANGER,
            # bmbt: BMBT,
            mfl: MFL
          }.freeze

          NOISEY = {
            ready: READY,
            speed: [SPEED],
            temperature: TEMPERATURE,
            ignition: IGNITION,
            sensors: SENSORS,
            country: COUNTRY,
            odometer: ODOMETER,
            vehicle: VEHICLE,
            lamp: LAMP,
            door: DOOR,
            navigation: NAVIGATION,
            gps: GPS
          }.freeze

          # UI = [
          #   RAD_EQ,
          #   RAD_ALT,
          #   OBC_VAR,
          #   OBC_BOOL,
          #   MENU_GT,
          #   MENU_RAD,
          #   RAD_LED,
          #   SRC_CTL,
          #   SRC_SND,
          #   SRC_GT
          # ].freeze
        end
      end
    end
  end
end
