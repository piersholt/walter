# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Command
        # Command Aliases
        module Aliases
          PING = 0x01
          PONG = 0x02

          LCD_SET = 0x05
          LCD_REP = 0x06

          IGNITION_REQ = 0x10
          IGNITION_REP = 0x11

          SENSORS_REQ = 0x12
          SENSORS_REP = 0x13

          COUNTRY_REQ = 0x14
          COUNTRY_REP = 0x15

          ODO_REQ = 0x16
          ODO_REP = 0x17

          SPEED_STATUS = 0x18

          TEMP_REQ = 0x1D
          TEMP_REP = 0x19

          TXT_CCM = 0x1A
          HUD_STATUS = 0x1B

          TEL_OPEN = 0x20

          TXT_MID    = 0x21
          GFX_STATUS = 0x22
          TXT_GFX    = 0x23
          TXT_NAV    = 0xA5

          ANZV_VAR   = 0x24
          ANZV_BOOL  = 0x2A
          TEL_LED    = 0x2B
          TEL_STATE  = 0x2C
          SOFT_INPUT = 0x31
          TEL_DATA   = SOFT_INPUT

          DSP_SET = 0x34
          DSP_EQ  = DSP_SET
          DSP_REP = 0x35
          RAD_EQ  = 0x36
          RAD_ALT = 0x37
          CDC_REQ = 0x38
          CDC_REP = 0x39
          # CDC_REP = CDC

          # GFX to IKE
          OBC_VAR = 0x40
          OBC_BOOL = 0x41

          MFL_VOL  = 0x32
          MFL_FUNC = 0x3B

          BMBT_I   = 0x47
          BMBT_A   = 0x48
          BMBT_B   = 0x49

          UI_CONFIG = 0x45
          UI_RADIO  = 0x46

          MENU_GFX = UI_CONFIG
          MENU_RAD = UI_RADIO

          RAD_LED = 0x4A
          SRC_CTL = 0x4B
          SRC_SND = 0x4E
          SRC_GFX = 0x4F

          CCM_END = 0x51
          CCM_TBC = 0x52
          IKE_BTN = 0x57

          VEH_REQ   = 0x53
          VEH_REP   = 0x54

          LAMP_REQ  = 0x5A
          LAMP_REP  = 0x5B

          CLUSTER_REP  = 0x5C
          CLUSTER_REQ  = 0x5D

          REMOTE = 0x72

          KEY_REQ = 0x73
          KEY_REP = 0x74

          DOOR_REQ = 0x79
          DOOR_REP = 0x7A

          COORDINATES = 0xA2
          ADDRESS     = 0xA4
          REAR        = 0xAB
          CELL        = 0xA9
          UTC         = 0x1F

          DIA_HELLO     = 0x00
          DIA_ERR_READ  = 0x04
          DIA_ERR_DEL   = 0x05
          DIA_COD_READ  = 0x08
          DIA_STATUS    = 0x0B
          DIA_VEH_CTRL  = 0x0C
          SLF_CHK       = 0x30
          EHC_DIG       = 0x3F
          EWS_ISN       = 0x60
          EWS_INT       = 0x6B
          EWS_COD       = 0x69
          EWS_KEY       = 0x65
          DIA_TRANS     = 0x9C
          EWS_X         = 0x9F
          EWS_END       = 0xA2
          DIA_DATA      = 0xA0
          DIA_MEM_READ  = 0x06
          DIA_MEM_WRITE = 0x07
          DIA_COD_WRITE = 0x09
        end
      end
    end
  end
end
