# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Contact Generators
        module Telematics
          Telematics = Struct.new(:city, :street, :latitude, :longitude)

          DEFAULT_SOS = 'SOS: 112!'

          DEGREES = 0xb0.chr

          CITY   = 'MELBOURNE, VIC'
          STREET = 'COLLINS ST;'
          LAT    = "37#{DEGREES} 48' 51.6\" South"
          LONG   = "144#{DEGREES} 58' 14.5\" East"

          def telematics
            @telematics ||= Telematics.new(CITY, STREET, LAT, LONG)
          end
        end
      end
    end
  end
end
