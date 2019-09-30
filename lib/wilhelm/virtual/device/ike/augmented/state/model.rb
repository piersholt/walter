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
                memo:            0,
                timer:           0,
                limit:           0,
                code:            0,
                aux_heating:     0,
                aux_timer_2:     0,
                aux_ventilation: 0,
                aux_timer_1:     0
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end

              # Control A

              def memo
                state[:memo]
              end

              def timer
                state[:timer]
              end

              def limit
                state[:limit]
              end

              def memo?
                bitwise_on?(memo, MASK[:memo])
              end

              def timer?
                bitwise_on?(timer, MASK[:timer])
              end

              def limit?
                bitwise_on?(limit, MASK[:limit])
              end

              # Control B

              def code
                state[:code]
              end

              def aux_heating
                state[:aux_heating]
              end

              def aux_timer_2
                state[:aux_timer_2]
              end

              def aux_ventilation
                state[:aux_ventilation]
              end

              def aux_timer_1
                state[:aux_timer_1]
              end

              def code?
                bitwise_on?(code, MASK[:code])
              end

              def aux_heating?
                bitwise_on?(aux_heating, MASK[:aux_heating])
              end

              def aux_timer_2?
                bitwise_on?(aux_timer_2, MASK[:aux_timer_2])
              end

              def aux_ventilation?
                bitwise_on?(aux_ventilation, MASK[:aux_ventilation])
              end

              def aux_timer_1?
                bitwise_on?(aux_timer_1, MASK[:aux_timer_1])
              end
            end
          end
        end
      end
    end
  end
end
