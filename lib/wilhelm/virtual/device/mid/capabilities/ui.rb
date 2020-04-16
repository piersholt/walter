# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module MID
        module Capabilities
          # MID::Capabilities::UI
          module UI
            include API

            def ui(arg1 = 0, arg2 = 0, arg3 = 0)
              ui_request(s1: arg1,s2: arg2,s3: arg3)
            end

            STATE_PRESS           = 0x00
            STATE_HOLD            = 0x20
            STATE_RELEASE         = 0x40

            def input(layout, function, action)
              soft_input(
                to: :ike,
                layout: layout,
                function: function,
                action: action | STATE_PRESS
              )
              Kernel.sleep(0.10)
              soft_input(
                to: :ike,
                layout: layout,
                function: function,
                action: action | STATE_RELEASE
              )
            end
          end
        end
      end
    end
  end
end
