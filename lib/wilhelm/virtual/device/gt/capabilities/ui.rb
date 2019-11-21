# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # GT::Capabilities::UserInterface
          module UserInterface
            include API

            MAIN_MENU     = 0b0000_0001
            SHOW_HEADER   = 0b0000_0010

            def main_menu
              config(config: MAIN_MENU)
            end

            def show_header
              config(config: SHOW_HEADER)
            end
          end
        end
      end
    end
  end
end
