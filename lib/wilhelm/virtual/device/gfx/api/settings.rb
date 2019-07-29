# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        module API
          # Settings/Configuration commands
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x40 OBC-VAR
            def obc_var(from: :gfx, to: :ike, **arguments)
              try(from, to, OBC_VAR, arguments)
            end

            # 0x41 OBC-BOOL
            def obc_bool(from: :gfx, to: :ike, **arguments)
              try(from, to, OBC_BOOL, arguments)
            end

            # 0x05 LCD-SET
            def lcd_brightness_set(from: :gfx, to: :bmbt, arguments:)
              try(from, to, LCD_SET, arguments)
            end

            alias obc_config obc_var
          end
        end
      end
    end
  end
end
