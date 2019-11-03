# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE::Augmented::State::Config
            module Config
              include Wilhelm::Helpers::PositionalNotation
              include Wilhelm::Helpers::Bitwise
              include Wilhelm::Helpers::DataTools
              include Virtual::Constants::Events::Cluster
              include Constants

              # PROPERTIES ----------------------------------------------------

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

              # MODIFIERS -----------------------------------------------------

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

              # STATE ---------------------------------------------------------

              # 0x2A ANZV-BOOL
              def anzv_bool!(value)
                # Can't rely upon XOR == 1 as first IKE sensor message
                # is published before monitor is on, the Unpowered state of which
                # will discard the code on event.
                if bitwise_on?(value, BITMASKS[:code])
                  changed
                  notify_observers(CODE_ON, device: ident)
                end

                xor = state[:anzv_bool] ^ value
                logger.debug(ident) { "ANZV-BOOL: #{d2b(state[:anzv_bool], true, true)} XOR #{d2b(value, true, true)} = #{d2b(xor, true, true)}" }
                modified = bitwise_any?(
                  xor,
                  BITMASKS[:memo],
                  BITMASKS[:timer],
                  BITMASKS[:limit],
                  BITMASKS[:code],
                  BITMASKS[:aux_heating],
                  BITMASKS[:aux_timer_2],
                  BITMASKS[:aux_ventilation],
                  BITMASKS[:aux_timer_1]
                )
                logger.debug(ident) { "ANZV-BOOL modified? #{modified} (#{d2b(xor, true, true)})" }
                state[:anzv_bool] = value
                return state[:anzv_bool] unless modified

                if bitwise_on?(xor, BITMASKS[:code])
                  case code?
                  when true
                    changed
                    notify_observers(CODE_ON, device: ident)
                  when false
                    changed
                    notify_observers(CODE_OFF, device: ident)
                  end
                end
              end

              # NOTE: api requires byte array of length 2
              # return value will need to be padded shoud value be 0
              # see -
              #   lib/wilhelm/virtual/device/gt/capabilities/obc.rb
              # usage -
              #   lib/wilhelm/virtual/device/gt/capabilities/obc/limit.rb:45
              def settings_bool
                base_256_digits(state[:anzv_bool])
              end
            end
          end
        end
      end
    end
  end
end
