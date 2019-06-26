# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        module API
          # Comment
          module LCD
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x05 LCD-SET
            def lcd_brightness_set(from: :gfx, to: :bmbt, arguments:)
              try(from, to, LCD_SET, arguments)
            end
          end
        end
      end
    end
  end
end
