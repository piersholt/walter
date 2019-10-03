# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/chainable'
require_relative 'state/model'

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Augmented IKE State
          module State
            include Wilhelm::Helpers::PositionalNotation
            include Wilhelm::Helpers::DataTools
            include Virtual::Constants::Events::Cluster
            include Model
            include Chainable

            # def ignition
            #   state[:ignition]
            # end

            # 0x2A ANZV-BOOL
            def anzv_bool!(value)
              xor = state[:anzv_bool] ^ value
              logger.debug(ident) { "ANZV-BOOL: #{d2b(state[:anzv_bool], true, true)} XOR #{d2b(value, true, true)} = #{d2b(xor, true, true)}" }
              modified = bitwise_on?(
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

            # 0x11 IGN
            def ignition!(value)
              xor = state[:ignition] ^ value
              logger.debug(ident) { "Ignition: #{d2b(state[:ignition], true, true)} XOR #{d2b(value, true, true)} = #{d2b(xor, true, true)}" }
              modified = bitwise_on?(xor, BITMASKS[:kl_30], BITMASKS[:kl_r], BITMASKS[:kl_15], BITMASKS[:kl_50])
              logger.debug(ident) { "Ignition modified? #{modified}" }
              # NOTE: case might have multiple bits... I only allow for single modified!
              # case xor
              # when BITMASKS[:kl_50]
              #   logger.debug(ident) { "#{bitwise_on?(value, BITMASKS[:kl_50]) ? 'Added:' : 'Removed:'} :kl_50" }
              # when BITMASKS[:kl_15]
              #   logger.debug(ident) { "#{bitwise_on?(value, BITMASKS[:kl_15]) ? 'Added:' : 'Removed:'} :kl_15" }
              # when BITMASKS[:kl_r]
              #   logger.debug(ident) { "#{bitwise_on?(value, BITMASKS[:kl_r]) ? 'Added:' : 'Removed:'} :kl_r" }
              # when BITMASKS[:kl_30]
              #   logger.debug(ident) { "#{bitwise_on?(value, BITMASKS[:kl_30]) ? 'Added:' : 'Removed:'} :kl_30" }
              # end if modified
              state[:ignition] = value
              return state[:ignition] unless modified

              case value
              when 0b0000_0000
                changed
                notify_observers(KL_30, device: ident)
              when 0b0000_0001
                changed
                notify_observers(KL_R, device: ident)
              when 0b0000_0011
                changed
                notify_observers(KL_15, device: ident)
              when 0b0000_0111
                changed
                notify_observers(KL_50, device: ident)
              end
            end

            # NOTE: api requires byte array of length 2
            # return value will need to be padded shoud value be 0
            # see -
            #   lib/wilhelm/virtual/device/gfx/capabilities/obc.rb
            # usage -
            #   lib/wilhelm/virtual/device/gfx/capabilities/obc/limit.rb:45
            def settings_bool
              base_256_digits(state[:anzv_bool])
            end

            # def control_a
            #   bitwise_or(
            #     memo,
            #     timer,
            #     limit
            #   )
            # end
            #
            # def control_b
            #   bitwise_or(
            #     code,
            #     aux_heating,
            #     aux_timer_2,
            #     aux_ventilation,
            #     aux_timer_1
            #   )
            # end
          end
        end
      end
    end
  end
end
