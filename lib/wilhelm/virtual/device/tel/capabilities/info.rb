# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Information
          module Info
            include API
            include Constants

            def open_info
              logger.unknown(PROC) { '#open_info()' }
              strength
              call_costs_current
              call_cost_total
              call_time_minutes
              call_time_seconds
            end

            def info_header(header = 'Info Title')
              draw_23(gfx: INFO_HEADER, chars: header)
            end

            # 0x91 Strength
            def strength(level = Random.rand(0..7))
              anzv_var_tel(field: STRENGTH, chars: bars(level))
            end

            # 0x91 Strength
            def strength!(chars)
              anzv_var_tel(field: STRENGTH, chars: chars)
            end

            # 0x93: Call cost current
            # "     0"
            def call_costs_current(current_cost = Random.rand(0..9))
              anzv_var_tel(field: CALL_COST_CURRENT, chars: current_cost)
            end

            # 0x94: Call cost total
            # "      0"
            def call_cost_total(total_cost = Random.rand(10..99))
              anzv_var_tel(field: CALL_COST_TOTAL, chars: total_cost)
            end

            # 0x96: Call Time minutes
            # "  0" {1,3}
            def call_time_minutes(minutes = rmin)
              anzv_var_tel(field: CALL_TIME_MINUTES, chars: minutes)
            end

            # 0x97: Call time seconds
            # " 0" {2,2}
            def call_time_seconds(seconds = rsec)
              anzv_var_tel(field: CALL_TIME_SECONDS, chars: seconds)
            end

            private

            # [0xb8, 0xb8, 0xb8, 0xb8, 0xb8, 0xb8, 0xb8]

            # 0 through 7 bars
            STRENGTHS = [0xB8, 0x5F, 0xB7, 0xB6, 0xB5, 0xB4, 0xB3, 0xB2].freeze

            def bars(level)
              [STRENGTHS[level]] + Array.new(6) { 0x5a }
            end

            MASK_MIN = '%i'
            MASK_SEC = '%.2i'

            def rmin
              format(MASK_MIN, Random.rand(0..59))
            end

            def rsec
              format(MASK_SEC, Random.rand(0..59))
            end
          end
        end
      end
    end
  end
end
