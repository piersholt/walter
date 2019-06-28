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
                memo:          MEMO[ON],
                timer:         TIMER[ON],
                limit:         LIMIT[ON],
                code:          CODE[ON],
                aux_led_flash: AUX_LED_FLASH[ON],
                aux_timer_2:   AUX_TIMER_2[ON],
                aux_direct:    AUX_DIRECT[ON],
                aux_timer_1:   AUX_TIMER_1[ON]
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

              def aux_led_flash
                state[:aux_led_flash]
              end

              def aux_led_flash?
                bitwise_on?(aux_led_flash, AUX_LED_FLASH[:on])
              end

              def aux_timer_2
                state[:aux_timer_2]
              end

              def aux_timer_2?
                bitwise_on?(aux_timer_2, AUX_TIMER_2[:on])
              end

              def aux_direct
                state[:aux_direct]
              end

              def aux_direct?
                bitwise_on?(aux_direct, AUX_DIRECT[:on])
              end

              def aux_timer_1
                state[:aux_timer_1]
              end

              def aux_timer_1?
                bitwise_on?(aux_timer_1, AUX_TIMER_1[:on])
              end

              def off!(*properties)
                properties.each do |property|
                  state[property] = ZERO
                end
              end
            end
          end
        end
      end
    end
  end
end
