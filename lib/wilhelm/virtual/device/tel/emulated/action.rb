# frozen_string_literal: true

require_relative 'action/directory'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Action
          module Action
            include Directory

            private

            def notify_of_action(action, **args)
              logger.unknown(PROC) { "#notify_of_action(#{action}, #{args})" }
              changed
              notify_observers(action, args)
            end
          end
        end
      end
    end
  end
end
