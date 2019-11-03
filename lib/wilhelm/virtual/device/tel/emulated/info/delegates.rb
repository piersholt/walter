# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Info
            # Device::Telephone::Emulated::Info::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'Info'

              def info_open
                LOGGER.debug(MOD_PROG) { '#info_open' }
                info!
                info_open!
                # info_clear
              end
            end
          end
        end
      end
    end
  end
end
