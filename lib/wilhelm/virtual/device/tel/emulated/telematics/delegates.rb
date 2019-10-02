# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Telematics
            # Device::Telephone::Emulated::Telematics::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'Mock::Telematics'

              def telematics_open
                LOGGER.debug(MOD_PROG) { '#telematics_open' }
                telematics!
                telematics_open!
              end

              # UPDATES -------------------------------------------------------

              def telematics_signal(command)
                case command.signal?
                when true
                  # signal!
                  true
                when false
                  # no_signal!
                  false
                end
              end

              def telematics_coordinates(latitude:, longitude:, vertical:)
                telematics_coordinates!(latitude.to_h, longitude.to_h, vertical)
              end

              def telematics_city(city)
                telematics_city!(city)
              end

              def telematics_street(street)
                telematics_street!(street)
              end

              # def telematics_select(index)
              #   LOGGER.debug(MOD_PROG) { "#telematics_select(#{index})" }
              #   telematics!
              #   telematics_select!(index: i)
              # end
            end
          end
        end
      end
    end
  end
end
