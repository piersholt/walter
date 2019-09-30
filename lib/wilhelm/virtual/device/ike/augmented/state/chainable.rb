# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE Chainable State Modifiers
            module Chainable
              include Constants

              # Control A

              def memo!
                state!(memo: MASK[:memo])
                self
              end

              def timer!
                state!(timer: MASK[:timer])
                self
              end

              def limit!
                state!(limit: MASK[:limit])
                self
              end

              # Control B

              def code!
                state!(code: MASK[:code])
                self
              end

              def aux_heating!
                state!(aux_heating: MASK[:aux_heating])
                self
              end

              def aux_timer_2!
                state!(aux_timer_2: MASK[:aux_timer_2])
                self
              end

              def aux_ventilation!
                state!(aux_ventilation: MASK[:aux_ventilation])
                self
              end

              def aux_timer_1!
                state!(aux_timer_1: MASK[:aux_timer_1])
                self
              end

              def off!(*properties)
                properties.each do |property|
                  state[property] = 0b0
                end
                self
              end
            end
          end
        end
      end
    end
  end
end
