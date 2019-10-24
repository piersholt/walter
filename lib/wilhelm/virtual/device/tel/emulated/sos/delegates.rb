# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module SOS
            # Device::Telephone::Emulated::SOS::Delegates
            module Delegates
              include Constants

              MOD_PROG = 'SOS'

              def sos_open
                LOGGER.debug(MOD_PROG) { '#sos_open' }
                sos!
                sos_open!
              end

              # UPDATES -------------------------------------------------------

              # 0xA2 COORDINATES
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

              # 0xA2 COORDINATES
              def telematics_coordinates(latitude:, longitude:, vertical:)
                telematics_coordinates!(latitude.to_h, longitude.to_h, vertical)
              end

              # 0xA4 ADDR
              def telematics_city(city)
                telematics_city!(city)
              end

              # 0xA4 ADDR
              def telematics_street(street)
                telematics_street!(street)
              end

              # def telematics_select(index)
              #   LOGGER.debug(MOD_PROG) { "#telematics_select(#{index})" }
              #   sos!
              #   telematics_select!(index: i)
              # end
            end
          end
        end
      end
    end
  end
end
