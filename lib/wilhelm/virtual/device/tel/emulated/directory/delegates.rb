# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Directory
            # Device::Telephone::Emulated::Directory::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'Directory'
              DIR_PAGE_SIZE = 8

              def directory_open
                LOGGER.debug(MOD_PROG) { '#directory_open' }
                directory!
                directory_open!(page_size: DIR_PAGE_SIZE)
                # directory_clear
              end

              def directory_back
                LOGGER.debug(MOD_PROG) { '#directory_back' }
                directory!
                @directory_page = directory_page - 1
                directory_back!(page: directory_page, page_size: DIR_PAGE_SIZE)
              end

              def directory_forward
                LOGGER.debug(MOD_PROG) { '#directory_forward' }
                directory!
                @directory_page = directory_page + 1
                directory_forward!(page: directory_page, page_size: DIR_PAGE_SIZE)
              end

              def directory_select(index)
                LOGGER.debug(MOD_PROG) { "#directory_select(#{index})" }
                directory!
                i = ACTION_CONTACT_INDICIES.index(index)
                directory_select!(index: i, page: directory_page, page_size: DIR_PAGE_SIZE)
              end

              private

              def directory_page
                @directory_page ||= 0
              end
            end
          end
        end
      end
    end
  end
end
