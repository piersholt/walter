# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module ZKE
            module Activate
              # Diagnostics::Capabilities::GM::CentralLocking
              module CentralLocking
                include Constants

                # NOTE: there's probably a motor activate too
                def rear_window_unlock
                  activate(BUTTON_REAR_WINDOW)
                end
              end
            end
          end
        end
      end
    end
  end
end
