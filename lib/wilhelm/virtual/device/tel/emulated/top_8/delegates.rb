# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Top8
            # Device::Telephone::Emulated::Top8::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'Mock::Top 8'

              def top_8_service_open
                LOGGER.unknown(MOD_PROG) { '#top_8_service_open' }
                top_8!
                top_8_open!
                # top_8_clear
              end

              def top_8_select(index)
                LOGGER.unknown(MOD_PROG) { "#top_8_select(#{index})" }
                top_8!
                i = ACTION_CONTACT_INDICIES.index(index)
                top_8_select!(index: i)
              end
            end
          end
        end
      end
    end
  end
end
