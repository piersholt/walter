# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            module Constants
              # Radio::Capabilities::UserInterface::Constants::Config
              module Config
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
end
