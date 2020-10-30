# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Activate
            module Activate
              include API

              def lcm(*args)
                api_vehicle_control(to: :lcm, arguments: args)
              end

              LEFT  = 0x80
              RIGHT = 0x40
              OFF = 0x00

              def indicate!(mask = 0x00)
                lcm(
                  0x00, 0x00, mask, 0x00,
                  0x00, 0x00, 0x00, 0x00,
                  0x00, 0x80, 0x80, 0x00
                )
              end

              def left!
                indicate!(LEFT)
              end

              def right!
                indicate!(RIGHT)
              end

              def off!
                indicate!(OFF)
              end

              alias l! left!
              alias r! right!
              alias o! off!
            end
          end
        end
      end
    end
  end
end
