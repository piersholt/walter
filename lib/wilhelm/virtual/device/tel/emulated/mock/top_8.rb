# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Telephone Top 8 Contacts
            module Top8
              include Constants
              # include Mock::Contacts

              MOD_PROG = 'Mock::Top 8'

              def top_8_service_open
                LOGGER.unknown(MOD_PROG) { '#top_8_service_open' }
                top_8!
                generate_top_8
                top_8_clear
              end

              def generate_top_8
                LOGGER.unknown(MOD_PROG) { '#generate_top_8()' }
                top_8_contact_list(*favourites)
              end

              def top_8_service_input(index)
                LOGGER.unknown(MOD_PROG) { "#top_8_service_input(#{index})" }
                top_8!
                i = ACTION_CONTACT_INDICIES.index(index)
                contact_name = favourites[i]
                top_8_name(contact_name)
              end
            end
          end
        end
      end
    end
  end
end
