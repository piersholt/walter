# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module API
          # Telephone::API::Display
          module Display
            include Device::API::BaseAPI
            include Constants

            # 0x23
            # Titles/Headings
            def draw_23(from: :tel, to: :gfx, **arguments)
              arguments[:ike] = IKE_DEFAULT unless arguments[:ike]
              parse_string(arguments)
              try(from, to, TXT_GFX, arguments)
            end

            alias primary draw_23

            # 0x21
            # Menus: Directory, Top 8
            def draw_21(from: :tel, to: :gfx, **arguments)
              arguments[:layout] = LAYOUT_DIRECTORY unless arguments[:layout]
              arguments[:m2] = M2_DEFAULT unless arguments[:m2]
              arguments[:m3] = M3_SOMETHING unless arguments[:m3]
              parse_string(arguments)
              try(from, to, TXT_MID, arguments)
            end

            alias mid draw_21

            # 0xA5
            # New Menus: Emergency/SOS
            def draw_a5(from: :tel, to: :gfx, **arguments)
              parse_string(arguments)
              try(from, to, TXT_NAV, arguments)
            end

            # 0x24 ANZV-VAR
            # Info: Sigal etc
            def anzv_var_tel(from: :tel, to: :gfx, **arguments)
              arguments[:ike] = IKE_ZERO unless arguments[:ike]
              parse_string(arguments)
              try(from, to, ANZV_VAR, arguments)
            end

            alias anzv_var anzv_var_tel
          end
        end
      end
    end
  end
end
