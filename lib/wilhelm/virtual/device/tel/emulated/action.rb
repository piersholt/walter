# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::State
          module Action
            def directory_service_open
              notify_of_action(DIRECTORY_OPEN)
            end

            def directory_back
              notify_of_action(DIRECTORY_BACK)
            end

            def directory_forward
              notify_of_action(DIRECTORY_FORWARD)
            end

            # @note might need state for input
            def directory_service_input(index)
              notify_of_action(DIRECTORY_SELECT, index: index)
            end

            private

            def notify_of_action(action, **args)
              changed
              notify_observers(
                action,
                args
              )
            end
          end
        end
      end
    end
  end
end
