# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module LastNumbers
            # Device::Telephone::Emulated::LastNumbers::Delegates
            module Delegates
              MOD_PROG = 'Mock::LastNumbers'

              def last_numbers_back
                LOGGER.unknown(MOD_PROG) { '#last_numbers_back' }
                dial!
                @page = page - 1
                last_numbers_back!(page: page)
              end

              def last_numbers_forward
                LOGGER.unknown(MOD_PROG) { '#last_numbers_forward' }
                dial!
                @page = page + 1
                last_numbers_forward!(page: page)
              end

              private

              # Last Numbers is "opened" via number forward,
              # thus seed value is -1 as first forward will
              # increment index by 1.
              def page
                @page ||= -1
              end
            end
          end
        end
      end
    end
  end
end
