# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module LastNumbers
            # Device::Telephone::Emulated::LastNumbers::Actions
            module Actions
              include Virtual::Constants::Events::Telephone

              def last_numbers_back!(page:)
                notify_of_action(LAST_NUMBERS_BACK, page: page)
              end

              def last_numbers_forward!(page:)
                notify_of_action(LAST_NUMBERS_FORWARD, page: page)
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
