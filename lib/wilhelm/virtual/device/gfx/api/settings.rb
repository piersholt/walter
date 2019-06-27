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

            # 0x40
            def obc_var(from: :gfx, to: :ike, **arguments)
              # LOGGER.unknown('API::OBC') { "#{from}, #{to}, #{arguments}" }
              try(from, to, OBC_VAR, arguments)
            end
            
            alias obc_config obc_var

            # 0x41
            def obc_bool(from: :gfx, to: :ike, **arguments)
              try(from, to, OBC_BOOL, arguments)
            end

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
