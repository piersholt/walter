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
              draw_23(gfx: INFO_HEADER, chars: header)
            end

            # 0x91 Strength
            def signal_strength(level)
              level = format_strength(level)
              anzv_var_tel(field: STRENGTH, chars: level)
            end

            # 0x93: Call cost current
            def call_costs_current(current_cost)
              current_cost = format_call_costs_current(current_cost)
              anzv_var_tel(field: CALL_COST_CURRENT, chars: current_cost)
            end

            # 0x94: Call cost total
            def call_cost_total(total_cost)
              total_cost = format_call_cost_total(total_cost)
              anzv_var_tel(field: CALL_COST_TOTAL, chars: total_cost)
            end

            # 0x96: Call Time minutes
            def call_time_minutes(minutes)
              minutes = format_call_time_minutes(minutes)
              anzv_var_tel(field: CALL_TIME_MINUTES, chars: minutes)
            end

            # 0x97: Call time seconds
            def call_time_seconds(seconds)
              seconds = format_call_time_seconds(seconds)
              anzv_var_tel(field: CALL_TIME_SECONDS, chars: seconds)
            end

            def macro_info(struct)
              signal_strength(struct.signal_strength)
              call_costs_current(struct.call_costs_current)
              call_cost_total(struct.call_cost_total)
              call_time_minutes(struct.call_time_minutes)
              call_time_seconds(struct.call_time_seconds)
            end

            private

            def format_strength(level)
              [STRENGTHS[level]] + Array.new(6) { 0x5a }
            end

            # "     0"
            def format_call_costs_current(value)
              format(MASK_CURRENT, value)
            end

            # "      0"
            def format_call_cost_total(value)
              format(MASK_TOTAL, value)
            end

            # "  0" {1,3}
            def format_call_time_minutes(value)
              format(MASK_MIN, value)
            end

            # " 0" {2,2}
            def format_call_time_seconds(value)
              format(MASK_SEC, value)
            end
          end
        end
      end
    end
  end
end
