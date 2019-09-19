# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Telephone::Capabilities::Mock::SOS
            module SOS
              include Constants

              MOD_PROG = 'Mock::SOS'
              DEFAULT_SOS = 'SOS: 112!'

              LOC_1 = 'MELBOURNE, VIC'
              LOC_2 = 'COLLINS ST;'

              DEGREES = 0xb0.chr
              LAT = "37#{DEGREES} 48' 51.6\" South"
              LONG = "144#{DEGREES} 58' 14.5\" East"

              def sos_service_open
                logger.unknown(MOD_PROG) { '#sos_service_open' }
                sos!
                generate_sos
              end

              def generate_sos
                logger.unknown(MOD_PROG) { '#generate_sos' }
                open_sos(LOC_1, LOC_2, LAT, LONG)
              end
            end
          end
        end
      end
    end
  end
end
