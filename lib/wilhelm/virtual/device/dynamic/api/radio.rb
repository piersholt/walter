# frozen_string_literal: true

module Wilhelm
  module Virtual
    module API
      # API for command related to keys
      module Radio
        include Wilhelm::Virtual::Constants::Command::Aliases
        include BaseAPI

        # BMBT

        # 0x4A
        def led(from: :rad, to: :bmbt, **arguments)
          format_chars!(arguments)
          try(from, to, RAD_LED, arguments)
        end

        def l(i)
          led(led: i)
        end

        # CD CHANGER

        # 0x38
        def cd_changer_request(from: :rad, to: :cdc, arguments:)
          try(from, to, CDC_REQ, arguments)
        end

        # MENU/USER INTERFACE

        # 0x46 MENU-RAD
        def menu_rad(from: :rad, to: :gfx, arguments:)
          try(from, to, MENU_RAD, arguments)
        end

        # 0x37 RAD-ALT
        def rad_alt(from: :rad, to: :gfx, **arguments)
          try(from, to, RAD_ALT, arguments)
        end

        # DISPLAY

        # 0x23
        def primary(from: :rad, to: :gfx, **arguments)
          format_chars!(arguments)
          try(from, to, TXT_GFX, arguments)
        end

        # 0xA5
        def secondary(from: :rad, to: :gfx, **arguments)
          format_chars!(arguments)
          try(from, to, TXT_NAV, arguments)
        end

        # 0x21
        def list(from: :rad, to: :gfx, **arguments)
          format_chars!(arguments)
          try(from, to, TXT_MID, arguments)
        end
      end
    end
  end
end
