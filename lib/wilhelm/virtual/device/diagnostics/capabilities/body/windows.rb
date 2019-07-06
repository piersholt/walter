# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            module Windows
              FRONT_RIGHT_OPEN  = '00 00 01'
              FRONT_RIGHT_CLOSE = '00 01 01'

              FRONT_LEFT_OPEN   = '00 03 01'
              FRONT_LEFT_CLOSE  = '00 04 01' # this is making rear left close...?

              REAR_RIGHT_CLOSE  = '00 44 01'
              REAR_RIGHT_OPEN   = '00 45 01'

              REAR_LEFT_CLOSE   = '00 46 01' # Good
              REAR_LEFT_OPEN    = '00 47 01' # Good

              SIGNAL_LIGHTS_ON = '00 63 01'

              REAR_OPEN = '00 64 01' # good
              FRONT_OPEN = '00 65 01' # good

              SUNROOF_OPEN = '00 66'

              # SUNROOF_OPEN  = '7E 01'
              SUNROOF_CLOSE = '7F 01'

              def window_fr_down
                api_vehicle_control(to: :gm, arguments: integers_input(0x00, 0x00, 0x01))
              end

              def window_fr_up
                api_vehicle_control(to: :gm, arguments: integers_input(0x00, 0x01, 0x01))
              end

              def window_fl_down
                api_vehicle_control(to: :gm, arguments: integers_input(0x00, 0x03, 0x01))
              end

              def window_fl_up
                api_vehicle_control(to: :gm, arguments: integers_input(0x00, 0x04, 0x01))
              end
            end
          end
        end
      end
    end
  end
end
