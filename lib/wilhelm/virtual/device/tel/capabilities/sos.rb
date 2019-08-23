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

            def open_sos(loc_a, loc_b, lat, long)
              logger.unknown(MOD_PROG) { "#open_sos(#{loc_a},#{loc_b},#{lat},#{long})" }
              lines = [
                HEADER,
                loc_a, loc_b, nil,
                lat, long
              ]
              macro_detail(LAYOUT_SOS, FUNCTION_SOS, lines, DEFAULT_SOS)
            end
          end
        end
      end
    end
  end
end
