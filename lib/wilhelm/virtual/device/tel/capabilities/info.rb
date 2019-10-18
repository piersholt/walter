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

            def info_header(header = 'Info Title')
              draw_23(gt: INFO_HEADER, chars: header)
            end

            # 0x91 Strength
            def strength(chars)
              anzv_var_tel(field: STRENGTH, chars: chars)
            end

            # 0x93: Call cost current
            # "     0"
            def call_costs_current(current_cost)
              anzv_var_tel(field: CALL_COST_CURRENT, chars: current_cost)
            end

            # 0x94: Call cost total
            # "      0"
            def call_cost_total(total_cost)
              anzv_var_tel(field: CALL_COST_TOTAL, chars: total_cost)
            end

            # 0x96: Call Time minutes
            # "  0" {1,3}
            def call_time_minutes(minutes)
              anzv_var_tel(field: CALL_TIME_MINUTES, chars: minutes)
            end

            # 0x97: Call time seconds
            # " 0" {2,2}
            def call_time_seconds(seconds)
              anzv_var_tel(field: CALL_TIME_SECONDS, chars: seconds)
            end
          end
        end
      end
    end
  end
end
