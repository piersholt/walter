# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # BMBT Interface Control
          module Info
            include API
            include Constants

            # 0x93: Call cost current
            # 0x94: Call cost total
            # 0x96: Call Time minutes
            # 0x97: Call time seconds
            def delegate_info
              hud(from: :tel, to: :gfx, gfx: 0x91, ike: 0x00, chars: [STRENGTH.shuffle.first])
              hud(from: :tel, to: :gfx, gfx: 0x93, ike: 0x00, chars: '123456789abcdef'.bytes)
              hud(from: :tel, to: :gfx, gfx: 0x94, ike: 0x00, chars: '123456789abcdef'.bytes)
              hud(from: :tel, to: :gfx, gfx: 0x96, ike: 0x00, chars: '123456789abcdef'.bytes)
              hud(from: :tel, to: :gfx, gfx: 0x97, ike: 0x00, chars: '123456789abcdef'.bytes)
            end
          end
        end
      end
    end
  end
end
