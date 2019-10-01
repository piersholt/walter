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
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:memo])
                self
              end

              def timer!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:timer])
                self
              end

              def limit!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:limit])
                self
              end

              # Control B

              def code!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:code])
                self
              end

              def aux_heating!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:aux_heating])
                self
              end

              def aux_timer_2!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:aux_timer_2])
                self
              end

              def aux_ventilation!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:aux_ventilation])
                self
              end

              def aux_timer_1!
                state!(anzv_bool: state[:anzv_bool] ^ BITMASKS[:aux_timer_1])
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
