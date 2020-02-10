# frozen_string_literal: false

require_relative 'activate/constants'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            # Diagnostics::Capabilities::GM::Activate
            module Activate
              include Constants

              # NOTE: this will conflict with other device modules
              def activate(byte_array)
                api_vehicle_control(to: :gm, arguments: byte_array)
              end

              def raw!(*bytes)
                activate(bytes)
              end

              def fetch!(constant)
                return false unless constant?(constant)
                activate(get_constant(constant))
              end

              private

              def constant?(constant)
                self.class.const_defined?(constant.to_sym.upcase)
              end

              def get_constant(constant)
                self.class.const_get(constant.to_sym.upcase)
              end

              public

              # NOTE: there's probably a motor activate too
              def rear_window_unlock
                activate(BUTTON_REAR_WINDOW)
              end

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
