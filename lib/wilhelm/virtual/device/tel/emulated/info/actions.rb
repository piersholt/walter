# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Info
            # Device::Telephone::Emulated::Info::Actions
            module Actions
              include Virtual::Constants::Events::Telephone

              def info_open!
                notify_of_action(INFO_OPEN)
              end

              private

              def notify_of_action(action, **args)
                logger.debug(PROC) { "#notify_of_action(#{action}, #{args})" }
                changed
                notify_observers(action, args)
              end
            end
          end
        end
      end
    end
  end
end
