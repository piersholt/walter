# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::SOS
          module SOS
            include API
            include Constants

            DEGREES = 0xb0.chr

            MOD_PROG = 'SOS'
            DEFAULT_SOS = 'SOS: 112!'
            HEADER = 'Your current position is:'

            def open_sos(city:, street:, latitude:, longitude:)
              logger.debug(MOD_PROG) { "#open_sos(#{city},#{street},#{latitude},#{longitude})" }
              lines = [
                HEADER,
                city, street, nil,
                latitude, longitude
              ]
              macro_detail(LAYOUT_SOS, FUNCTION_TELEMATICS, lines, DEFAULT_SOS)
            end
          end
        end
      end
    end
  end
end
