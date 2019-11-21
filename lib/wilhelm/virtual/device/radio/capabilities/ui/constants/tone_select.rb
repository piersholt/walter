# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            module Constants
              # Radio::Capabilities::UserInterface::Constants::ToneSelect
              module ToneSelect
                SELECT_CONFIRM    = 0b0000_0001
                SELECT_HIGHLIGHT  = 0b0000_0100

                SELECT_RADIO      = 0b0000_0000
                SELECT_CDC        = 0b0000_1000

                SELECT_OPTION_1   = 0b0000_0000
                SELECT_OPTION_2   = 0b0001_0000
                SELECT_OPTION_3   = 0b0010_0000
                SELECT_OPTION_4   = 0b0011_0000

                SELECT_BM53       = 0b0000_0000
                SELECT_C23        = 0b0100_0000

                TONE_EQ           = 0b1000_0000

                TONE_EQ_MAGNITUDE = 0b0000_1111
                TONE_EQ_SIGN      = 0b0001_0000

                TONE_BASS         = 0b0100_0000 # 0xc0
                TONE_TREBLE       = 0b0101_0000 # 0xd0
                TONE_FADER        = 0b0110_0000 # 0xe0
                TONE_BALANCE      = 0b0111_0000 # 0xf0
              end
            end
          end
        end
      end
    end
  end
end
