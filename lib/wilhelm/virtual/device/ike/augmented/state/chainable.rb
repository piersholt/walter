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

              def aux_led_flash!
                state[:aux_led_flash] = AUX_LED_FLASH[:on]
                self
              end

              def aux_timer_2!
                state[:aux_timer_2] = AUX_TIMER_2[:on]
                self
              end

              def aux_direct!
                state[:aux_direct] = AUX_DIRECT[:on]
                self
              end

              def aux_timer_1!
                state[:aux_timer_1] = AUX_TIMER_1[:on]
                self
              end
            end
          end
        end
      end
    end
  end
end
