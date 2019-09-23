# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Top8
            # Device::Telephone::Emulated::Top8::Actions
            module Actions
              include Virtual::Constants::Events::Telephone

              def top_8_open!
                notify_of_action(TOP_8_OPEN)
              end

              def top_8_select!(index:)
                notify_of_action(TOP_8_SELECT, index: index)
              end

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
end
