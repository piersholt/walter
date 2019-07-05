# frozen_string_literal: true

require_relative 'api/led'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Radio API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI
          include LED

          # BMBT

          # 0x4A
          # def led(from: :rad, to: :bmbt, **arguments)
          #   format_chars!(arguments)
          #   try(from, to, RAD_LED, arguments)
          # end
          #
          # def l(i)
          #   led(led: i)
          # end

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
          def draw_23(from: :rad, to: :gfx, **arguments)
            format_chars!(arguments)
            try(from, to, TXT_GFX, arguments)
          end

          alias primary draw_23

          # 0xA5
          def draw_a5(from: :rad, to: :gfx, **arguments)
            format_chars!(arguments)
            try(from, to, TXT_NAV, arguments)
          end

          alias secondary draw_a5

          # 0x21
          def draw_21(from: :rad, to: :gfx, **arguments)
            format_chars!(arguments)
            try(from, to, TXT_MID, arguments)
          end

          alias list draw_21
        end
      end
    end
  end
end
