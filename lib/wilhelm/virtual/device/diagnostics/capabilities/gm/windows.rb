# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            # Diagnostics::Capabilities::Body::Windows
            module Windows
              include Constants

              def window_driver_open
                body_diag(WINDOW_DRIVER_OPEN)
              end

              def window_driver_close
                body_diag(WINDOW_DRIVER_CLOSE)
              end

              def window_passenger_open
                body_diag(WINDOW_PASS_OPEN)
              end

              def window_passenger_close
                body_diag(WINDOW_PASS_CLOSE)
              end

              def window_driver_rear_close
                body_diag(WINDOW_DRIVER_REAR_CLOSE)
              end

              def window_driver_rear_open
                body_diag(WINDOW_DRIVER_REAR_OPEN)
              end

              def window_passenger_rear_close
                body_diag(WINDOW_PASS_REAR_CLOSE)
              end

              def window_passenger_rear_open
                body_diag(WINDOW_PASS_REAR_OPEN)
              end
            end
          end
        end
      end
    end
  end
end
