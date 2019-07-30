# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # API for telephone related commands
        module API
          include Virtual::Constants::Command::Aliases
          include Device::API::BaseAPI
          include Constants

          TEL_DIRECTORY = 0x43

          # 0x21
          # Contacts
          def draw_21(from: :tel, to: :gfx, **arguments)
            arguments[:layout] = LAYOUT_DIRECTORY unless arguments[:layout]
            arguments[:m2] = M2_DEFAULT unless arguments[:m2]
            arguments[:m3] = M3_SOMETHING unless arguments[:m3]
            # format_chars!(arguments)
            try(from, to, TXT_MID, arguments)
          end

          alias mid draw_21

          # 0x23
          def draw_23(from: :tel, to: :gfx, **arguments)
            arguments[:ike] = IKE_DEFAULT unless arguments[:ike]
            format_chars!(arguments)
            try(from, to, TXT_GFX, arguments)
          end

          alias primary draw_23

          # ANZV VAR -----------------------------------------------------------

          # 0x24 ANZV-VAR
          # Info: Sigal etc
          def anzv_var(from: :tel, to: :gfx, **arguments)
            arguments[:ike] = NIL unless arguments[:ike]
            # format_chars!(arguments)
            try(from, to, ANZV_VAR, arguments)
          end

          # ANZV BOOLEAN -------------------------------------------------------

          # 0x2b ANZV-BOOL
          def anzv_bool_led(from: :tel, to: :anzv, **arguments)
            try(from, to, TEL_LED, arguments)
          end

          alias led anzv_bool_led

          # 0x2c ANZV-BOOL
          def anzv_bool_status(from: :tel, to: :anzv, **arguments)
            try(from, to, TEL_STATE, arguments)
          end

          alias status anzv_bool_status
        end
      end
    end
  end
end
