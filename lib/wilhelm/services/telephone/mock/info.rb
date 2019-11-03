# frozen_string_literal: true

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Mock Info
        module Info
          Info = Struct.new(
            :signal_strength,
            :call_costs_current,
            :call_cost_total,
            :call_time_minutes,
            :call_time_seconds
          )

          def info
            Info.new(
              rstrength,
              rcurrent,
              rtotal,
              rmin,
              rsec
            )
          end

          private

          def rstrength
            Random.rand(1..7)
          end

          def rcurrent
            Random.rand(0..9)
          end

          def rtotal
            Random.rand(10..99)
          end

          def rmin
            Random.rand(0..59)
          end

          def rsec
            Random.rand(0..59)
          end
        end
      end
    end
  end
end
