# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module API
          # Settings/Configuration commands
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x06 LCD-REP
            def lcd_brightness_reply(from: :bmbt, to: :gt, arguments:)
              try(from, to, LCD_REP, arguments)
            end
          end
        end
      end
    end
  end
end
