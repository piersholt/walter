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
                @index = index - 1
                last_numbers_back!(index: index)
              end

              def last_numbers_forward
                LOGGER.unknown(MOD_PROG) { '#last_numbers_forward' }
                dial!
                @index = index + 1
                last_numbers_forward!(index: index)
              end

              private

              def index
                @index ||= 0
              end
            end
          end
        end
      end
    end
  end
end
