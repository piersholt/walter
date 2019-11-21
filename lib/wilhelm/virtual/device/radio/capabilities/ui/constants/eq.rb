# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            module Constants
              # Radio::Capabilities::UserInterface::Constants::EQ
              module EQ
                EQ_SMR_MAGNITUDE  = 0b000_0_1111
                EQ_SMR_POSITIVE   = 0b000_1_0000
                EQ_BALANCE        = 0b010_0_0000 # 0x40
                EQ_BASS           = 0b011_0_0000 # 0x60
                EQ_FADER          = 0b100_0_0000 # 0x80
                EQ_TREBLE         = 0b110_0_0000 # 0xc0
              end
            end
          end
        end
      end
    end
  end
end
