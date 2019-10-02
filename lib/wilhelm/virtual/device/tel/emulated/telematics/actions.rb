# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Telematics
            # Device::Telephone::Emulated::Telematics::Actions
            module Actions
              include Virtual::Constants::Events::Telephone

              def telematics_coordinates!(latitude, longitude, vertical)
                notify_of_action(
                  TELEMATICS_COORD,
                  latitude: latitude,
                  longitude: longitude,
                  vertical: vertical
                )
              end

              def telematics_city!(city)
                notify_of_action(
                  TELEMATICS_ADDR,
                  city: city
                )
              end

              def telematics_street!(street)
                notify_of_action(
                  TELEMATICS_ADDR,
                  street: street
                )
              end

              def telematics_open!
                notify_of_action(TELEMATICS_OPEN)
              end

              private

              def notify_of_action(action, **args)
                logger.debug(PROC) { "#notify_of_action(#{action}, #{args})" }
                changed
                notify_observers(action, args)
              end
            end
          end
        end
      end
    end
  end
end
