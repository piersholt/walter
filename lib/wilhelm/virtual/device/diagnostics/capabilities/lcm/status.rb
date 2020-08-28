# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Status
            module Activate
              include API

              def lcm_status
                api_status(from: :dia, to: :lcm, arguments: [])
              end

              # 01 00 00 00 00 00 00 00 00 53 34 00
              def lcm_activate(*args)
                # lcm_activate(01, 00, 00, 00, 00, 00, 00, 00, 00, 53, 34, 00)
                api_vehicle_control(from: :dia, to: :lcm, arguments: args)
              end
            end
          end
        end
      end
    end
  end
end
