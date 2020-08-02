# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            # Radio::Capabilities::UserInterface::Constants
            module Constants
              # 0x36
              EQ_BALANCE        = 0b010_00000 # 0x40
              EQ_BASS           = 0b011_00000 # 0x60
              EQ_FADER          = 0b100_00000 # 0x80
              EQ_TREBLE         = 0b110_00000 # 0xc0

              EQ_SMR_POSITIVE   = 0b000_1_0000
              EQ_SMR_MAGNITUDE  = 0b000_0_1111

              # 0x37
              SELECT_BM53       = 0b00_00_0_000
              SELECT_C23        = 0b01_00_0_000
              TONE_SET          = 0b10_00_0_000
              TONE_EDIT         = 0b11_00_0_000

              SELECT_A          = 0b00_00_0_000
              SELECT_B          = 0b00_01_0_000
              SELECT_C          = 0b00_10_0_000
              SELECT_D          = 0b00_11_0_000
              TONE_BASS         = 0b00_00_0_000 # 0xc0
              TONE_TREBLE       = 0b00_01_0_000 # 0xd0
              TONE_FADER        = 0b00_10_0_000 # 0xe0
              TONE_BALANCE      = 0b00_11_0_000 # 0xf0

              SOURCE_RADIO      = 0b00_00_0_000
              SOURCE_CDC        = 0b00_00_1_000

              SELECT_HIGHLIGHT  = 0b00_00_0_100
              SELECT_CONFIRM    = 0b00_00_0_101

              TONE_EQ_SIGN      = 0b000_1_0000
              TONE_EQ_MAGNITUDE = 0b000_0_1111

              # 0x46
              MAIN_MENU     = 0b0000_0001
              HIDE_HEADER   = 0b0000_0010
              HIDE_SELECT   = 0b0000_0100
              HIDE_TONE     = 0b0000_1000
              HIDE_MENU     = 0b0000_1100
              HIDE_OVERLAY  = 0b0000_1110 # C23 hide overlay
            end
          end
        end
      end
    end
  end
end
