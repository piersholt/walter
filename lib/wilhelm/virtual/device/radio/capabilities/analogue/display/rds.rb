# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Analogue
            module Display
              # Analogue::Display::RDS
              # 0x43
              module RDS
                include API
                include Constants

                BANDS_A = " A1\x05A2 \x05 A3\x05A4 \x05 A5\x05A6 "
                BANDS_1 = " 1 \x05 2 \x05 3 \x05 4 \x05 5 \x05 6 "
                BANDS_2 = " 7 \x05 8 \x05 9 \x0510 \x05 11\x0512 "

                BANDS = {
                  fma:  BANDS_A,
                  fm1:  BANDS_1,
                  fm2:  BANDS_2,
                  ama:  BANDS_A,
                  am:   BANDS_1
                }.freeze

                def band(band_id = :fma)
                  draw_21(
                    layout: SOURCE_ANALOGUE | ANALOGUE_RDS,
                    m2:     BAND.fetch(band_id, BAND[:fma]),
                    m3:     INDEX_BAND_PRESETS,
                    chars:  BANDS.fetch(band_id, BANDS[:fma])
                  )
                end

                # Note: band bitmask should also be set
                def rds(rds_bitmask = RDS[:rds], band_bitmask = BAND[:fma])
                  draw_21(
                    layout: SOURCE_ANALOGUE | ANALOGUE_RDS,
                    m2:     band_bitmask | rds_bitmask,
                    m3:     INDEX_RDS,
                    chars:  "FM\x05AM\x05PTY\x05RDS\x05SC\x05MODE"
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
