# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE State Model
            module Model
              include Wilhelm::Helpers::Stateful
              include Wilhelm::Helpers::Bitwise
              include Constants

              DEFAULT_STATE = {
                memo:          MEMO[OFF],
                timer:         TIMER[OFF],
                limit:         LIMIT[OFF],
                code:          CODE[OFF],
                aux_heating: AUX_HEATING[OFF],
                aux_timer_2:   AUX_TIMER_2[OFF],
                aux_ventilation:    AUX_VENTILATION[OFF],
                aux_timer_1:   AUX_TIMER_1[OFF]
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end

              # Control A

              def memo
                state[:memo]
              end

              def memo?
                bitwise_on?(memo, MEMO[:on])
              end

              def timer
                state[:timer]
              end

              def timer?
                bitwise_on?(timer, TIMER[:on])
              end

              def limit
                state[:limit]
              end

              def limit?
                bitwise_on?(limit, LIMIT[:on])
              end

              # Control B

              def code
                state[:code]
              end

              def code?
                bitwise_on?(code, CODE[:on])
              end

              def aux_heating
                state[:aux_heating]
              end

              def aux_heating?
                bitwise_on?(aux_heating, AUX_HEATING[:on])
              end

              def aux_timer_2
                state[:aux_timer_2]
              end

              def aux_timer_2?
                bitwise_on?(aux_timer_2, AUX_TIMER_2[:on])
              end

              def aux_ventilation
                state[:aux_ventilation]
              end

              def aux_ventilation?
                bitwise_on?(aux_ventilation, AUX_VENTILATION[:on])
              end

              def aux_timer_1
                state[:aux_timer_1]
              end

              def aux_timer_1?
                bitwise_on?(aux_timer_1, AUX_TIMER_1[:on])
              end
            end
          end
        end
      end
    end
  end
end
