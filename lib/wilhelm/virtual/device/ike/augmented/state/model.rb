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
                ignition: 0b0000_0000,
                anzv_bool: 0b0000_0000_0000_0000
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end

              # Ignition

              def kl_30?
                bitwise_on?(state[:ignition], BITMASKS[:kl_30])
              end

              def kl_r?
                bitwise_on?(state[:ignition], BITMASKS[:kl_r])
              end

              def kl_15?
                bitwise_on?(state[:ignition], BITMASKS[:kl_15])
              end

              def kl_50?
                bitwise_on?(state[:ignition], BITMASKS[:kl_50])
              end

              # Control A

              def memo?
                bitwise_on?(state[:anzv_bool], BITMASKS[:memo])
              end

              def timer?
                bitwise_on?(state[:anzv_bool], BITMASKS[:timer])
              end

              def limit?
                bitwise_on?(state[:anzv_bool], BITMASKS[:limit])
              end

              # Control B

              def code?
                bitwise_on?(state[:anzv_bool], BITMASKS[:code])
              end

              def aux_heating?
                bitwise_on?(state[:anzv_bool], BITMASKS[:aux_heating])
              end

              def aux_timer_2?
                bitwise_on?(state[:anzv_bool], BITMASKS[:aux_timer_2])
              end

              def aux_ventilation?
                bitwise_on?(state[:anzv_bool], BITMASKS[:aux_ventilation])
              end

              def aux_timer_1?
                bitwise_on?(state[:anzv_bool], BITMASKS[:aux_timer_1])
              end
            end
          end
        end
      end
    end
  end
end
