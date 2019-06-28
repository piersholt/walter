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

              def memo!
                state[:memo] = MEMO[:on]
                self
              end

              def timer!
                state[:timer] = TIMER[:on]
                self
              end

              def limit!
                state[:limit] = LIMIT[:on]
                self
              end

              def code!
                state[:code] = CODE[:on]
                self
              end

              def aux_heating!
                state[:aux_heating] = AUX_HEATING[:on]
                self
              end

              def aux_timer_2!
                state[:aux_timer_2] = AUX_TIMER_2[:on]
                self
              end

              def aux_ventilation!
                state[:aux_ventilation] = AUX_VENTILATION[:on]
                self
              end

              def aux_timer_1!
                state[:aux_timer_1] = AUX_TIMER_1[:on]
                self
              end

              def off!(*properties)
                properties.each do |property|
                  state[property] = ZERO
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
