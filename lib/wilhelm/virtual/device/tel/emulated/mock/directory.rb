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

              MOD_PROG = 'Mock::Directory'
              DIR_PAGE_SIZE = 8

              def directory_open
                LOGGER.unknown(MOD_PROG) { '#directory_open' }
                directory!
                directory_open!(page_size: DIR_PAGE_SIZE)
                # directory_clear
              end

              def directory_back
                LOGGER.unknown(MOD_PROG) { '#directory_back' }
                directory!
                @page = page - 1
                directory_back!(page: page, page_size: DIR_PAGE_SIZE)
              end

              def directory_forward
                LOGGER.unknown(MOD_PROG) { '#directory_forward' }
                directory!
                @page = page + 1
                directory_forward!(page: page, page_size: DIR_PAGE_SIZE)
              end

              def directory_select(index)
                LOGGER.unknown(MOD_PROG) { "#directory_select(#{index})" }
                directory!
                i = ACTION_CONTACT_INDICIES.index(index)
                directory_select!(index: i, page: page, page_size: DIR_PAGE_SIZE)
              end

              private

              def page
                @page ||= 0
              end
            end
          end
        end
      end
    end
  end
end
