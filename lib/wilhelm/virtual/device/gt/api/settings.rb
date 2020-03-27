# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Settings/Configuration commands
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            def region?(from: :gt, to: :ike, **arguments)
              try(from, to, 0x14, arguments)
            end

            # 0x15 REGION-SET
            def region(from: :gt, to: :ike, **arguments)
              try(from, to, COUNTRY_REP, arguments)
            end

            def region!(lang = 0x01, b2 = 0xf4, b3 = 0x70, b4 = 0x42)
              region(lang: lang, b2: b2, b3: b3, b4: b4)
            end

            # 0x40 OBC-VAR
            def obc_var(from: :gt, to: :ike, **arguments)
              try(from, to, OBC_VAR, arguments)
            end

            # 0x41 OBC-BOOL
            def obc_bool(from: :gt, to: :ike, **arguments)
              try(from, to, OBC_BOOL, arguments)
            end

            # 0x05 LCD-SET
            def lcd_brightness_set(from: :gt, to: :bmbt, arguments:)
              try(from, to, LCD_SET, arguments)
            end

            alias obc_config obc_var

            # 0x24 ANZV-VAR-IKE
            def anzv_var(from: :gt, to: :ike, **arguments)
              # format_chars!(arguments)
              try(from, to, ANZV_VAR, arguments)
            end

            # 0x2a ANZV-BOOL-IKE
            def anzv_bool(from: :gt, to: :ike, **arguments)
              try(from, to, ANZV_BOOL, arguments)
            end
          end
        end
      end
    end
  end
end
