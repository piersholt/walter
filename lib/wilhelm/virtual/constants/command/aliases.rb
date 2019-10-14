# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Command
        # Virtual::Constants::Command::Aliases
        module Aliases
          PING          = 0x01
          PONG          = 0x02

          LCD_SET       = 0x05
          LCD_REP       = 0x06

          IGNITION_REQ  = 0x10
          IGNITION_REP  = 0x11

          SENSORS_REQ   = 0x12
          SENSORS_REP   = 0x13

          COUNTRY_REQ   = 0x14
          COUNTRY_REP   = 0x15

          ODO_REQ       = 0x16
          ODO_REP       = 0x17

          SPEED         = 0x18

          TEMP_REQ      = 0x1d
          TEMP_REP      = 0x19

          TXT_CCM       = 0x1a
          HUD_STATUS    = 0x1b

          TEL_OPEN      = 0x20

          TXT_MID       = 0x21
          GFX_STATUS    = 0x22
          TXT_GFX       = 0x23
          TXT_NAV       = 0xa5

          ANZV_VAR      = 0x24
          ANZV_BOOL     = 0x2a
          TEL_LED       = 0x2b
          TEL_STATE     = 0x2c

          INPUT         = 0x31

          MFL_VOL       = 0x32
          MFL_FUNC      = 0x3b

          DSP_SET       = 0x34
          DSP_REP       = 0x35

          RAD_EQ        = 0x36
          RAD_ALT       = 0x37
          CDC_REQ       = 0x38
          CDC_REP       = 0x39

          OBC_VAR       = 0x40
          OBC_BOOL      = 0x41

          PROG          = 0x42

          MENU_GFX      = 0x45
          MENU_RAD      = 0x46

          BMBT_I        = 0x47
          BMBT_A        = 0x48
          BMBT_B        = 0x49

          RAD_LED       = 0x4a
          SRC_CTL       = 0x4b
          SRC_SND       = 0x4e
          SRC_GFX       = 0x4f

          CCM_END       = 0x51
          CCM_RLY       = 0x52
          IKE_BTN       = 0x57

          VEH_LCM_REQ   = 0x53
          VEH_LCM       = 0x54
          VEH_IKE       = 0x55

          LAMP_REQ      = 0x5a
          LAMP_REP      = 0x5b

          # 58G
          CLUSTER_REP   = 0x5c
          # 58G-REQ
          CLUSTER_REQ   = 0x5d

          REMOTE        = 0x72
          KEY_REQ       = 0x73
          KEY_REP       = 0x74

          DOOR_REQ      = 0x79
          DOOR_REP      = 0x7a

          UTC           = 0x1f
          COORDINATES   = 0xa2
          ADDRESS       = 0xa4
          ASSIST        = 0xa9
          CELL          = ASSIST
          GFX2          = 0xab
          REAR          = GFX2
          SES           = 0xaf

          # Diagnostics
          DIA_HELLO     = 0x00

          DIA_ERR_READ  = 0x04
          DIA_ERR_DEL   = 0x05

          DIA_MEM_READ  = 0x06
          DIA_MEM_WRITE = 0x07

          DIA_COD_READ  = 0x08
          DIA_COD_WRITE = 0x09
        end
      end
    end
  end
end
