# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module SMS
            # Device::Telephone::Emulated::SMS::Actions
            module Actions
              include Virtual::Constants::Events::Telephone

              def sms_open!(page: 0, page_size:)
                notify_of_action(
                  SMS_OPEN,
                  page: page, page_size: page_size
                )
              end

              def sms_select!(index:, page:, page_size:)
                notify_of_action(
                  SMS_SELECT,
                  index: index, page: page, page_size: page_size
                )
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
