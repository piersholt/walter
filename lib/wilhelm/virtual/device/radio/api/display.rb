# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module API
          # Radio::API::Display
          module Display
            include Device::API::BaseAPI

            # 0x23
            def draw_23(from: :rad, to: :gt, **arguments)
              format_chars!(arguments)
              try(from, to, TXT_GT, arguments)
            end

            alias primary draw_23

            def draw_23!(from = :ike, gt = 0x00, ike = 0x20, chars)
              draw_23(from: from, to: :gt, gt: gt, ike: ike, chars: chars)
            end

            # 0x24
            def draw_24(from: :rad, to: :gt, **arguments)
              format_chars!(arguments)
              try(from, to, ANZV_VAR, arguments)
            end

            def draw_24!(from = :rad, field = 0x00, ike = 0x20, chars)
              draw_24(from: from, to: :gt, field: field, ike: ike, chars: chars)
            end

            # 0x21
            def draw_21(from: :rad, to: :gt, **arguments)
              format_chars!(arguments)
              try(from, to, TXT_MID, arguments)
            end

            alias list draw_21

            # 0xA5
            def draw_a5(from: :rad, to: :gt, **arguments)
              format_chars!(arguments)
              try(from, to, TXT_NAV, arguments)
            end

            alias secondary draw_a5
          end
        end
      end
    end
  end
end
