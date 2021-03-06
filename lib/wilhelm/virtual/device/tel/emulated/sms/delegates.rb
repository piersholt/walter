# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module SMS
            # Device::Telephone::Emulated::SMS::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'SMS'
              SMS_PAGE_SIZE = 10

              def sms_open
                LOGGER.debug(MOD_PROG) { '#sms_open' }
                sms_index!
                sms_open!(page_size: SMS_PAGE_SIZE)
                # sms_clear
              end

              def sms_select(index)
                LOGGER.debug(MOD_PROG) { "#sms_select(#{index})" }
                sms_index!
                i = ACTION_SMS_INDICIES.index(index)
                sms_select!(index: i, page: sms_page, page_size: SMS_PAGE_SIZE)
              end

              private

              def sms_page
                @sms_page ||= 0
              end
            end
          end
        end
      end
    end
  end
end
