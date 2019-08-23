# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Telephone Top 8 Contacts
            module Directory
              include Constants
              include Mock::Contacts

              MOD_PROG = 'Mock::Directory'
              DIR_PAGE_SIZE = 8

              def directory_service_open
                LOGGER.unknown(MOD_PROG) { '#directory_service_open' }
                directory!
                generate_directory
                directory_clear
              end

              def generate_directory(offset = directory_shift)
                LOGGER.unknown(MOD_PROG) { "#generate_directory(#{offset})" }
                phone_book.rotate!(offset)
                contacts = phone_book.first(DIR_PAGE_SIZE)
                directory_contact_list(*contacts)
              end

              def directory_back
                LOGGER.unknown(MOD_PROG) { '#directory_back' }
                directory!
                @directory_shift = - DIR_PAGE_SIZE
                generate_directory(directory_shift)
              end

              def directory_forward
                LOGGER.unknown(MOD_PROG) { '#directory_forward' }
                directory!
                @directory_shift = DIR_PAGE_SIZE
                generate_directory(directory_shift)
              end

              def directory_service_input(index)
                LOGGER.unknown(MOD_PROG) { "#directory_service_input(#{index})" }
                directory!
                i = ACTION_CONTACT_INDICIES.index(index)
                contact_name = phone_book[i]
                directory_name(contact_name)
              end

              def directory_shift
                @directory_shift ||= 0
              end
            end
          end
        end
      end
    end
  end
end
