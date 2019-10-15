# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            module Activate
              # Diagnostics::Capabilities::GM::CentralLocking
              module CentralLocking
                include Constants

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
