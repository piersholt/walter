# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module LastNumbers
            # Device::Telephone::Emulated::LastNumbers::Delegates
            module Delegates
              MOD_PROG = 'LastNumbers'

              def last_numbers_back
                LOGGER.unknown(MOD_PROG) { '#last_numbers_back' }
                last_numbers!
                @last_numbers_page = last_numbers_page - 1
                last_numbers_back!(page: last_numbers_page)
              end

              def last_numbers_forward
                LOGGER.unknown(MOD_PROG) { '#last_numbers_forward' }
                last_numbers!
                @last_numbers_page = last_numbers_page + 1
                last_numbers_forward!(page: last_numbers_page)
              end

              private

              # Last Numbers is "opened" via number forward,
              # thus seed value is -1 as first forward will
              # increment index by 1.
              def last_numbers_page
                @last_numbers_page ||= -1
              end
            end
          end
        end
      end
    end
  end
end
