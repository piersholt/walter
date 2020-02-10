# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::Windows
              module Windows
                include Constants

                def window_driver_open
                  activate(WINDOW_DRIVER_OPEN)
                end

                def window_driver_close
                  activate(WINDOW_DRIVER_CLOSE)
                end

                def window_passenger_open
                  activate(WINDOW_PASS_OPEN)
                end

                def window_passenger_close
                  activate(WINDOW_PASS_CLOSE)
                end

                def window_driver_rear_close
                  activate(WINDOW_DRIVER_REAR_CLOSE)
                end

                def window_driver_rear_open
                  activate(WINDOW_DRIVER_REAR_OPEN)
                end

                def window_passenger_rear_close
                  activate(WINDOW_PASS_REAR_CLOSE)
                end

                def window_passenger_rear_open
                  activate(WINDOW_PASS_REAR_OPEN)
                end
              end
            end
          end
        end
      end
    end
  end
end
