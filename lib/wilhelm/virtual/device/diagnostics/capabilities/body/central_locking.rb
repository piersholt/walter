# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module Body
            # Diagnostics::Capabilities::Body::CentralLocking
            module CentralLocking
              include Constants

              def rear_window_unlock
                body_diag(BUTTON_REAR_WINDOW)
              end
            end
          end
        end
      end
    end
  end
end
