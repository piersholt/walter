# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE::Augmented::State::Ignition
            module Ignition
              include Wilhelm::Helpers::PositionalNotation
              include Wilhelm::Helpers::DataTools
              include Wilhelm::Helpers::Bitwise

              include Virtual::Constants::Events::Cluster
              include Constants

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

              def ignition!(value)
                xor = state[:ignition] ^ value
                logger.debug(ident) { "Ignition: #{d2b(state[:ignition], true, true)} XOR #{d2b(value, true, true)} = #{d2b(xor, true, true)}" }
                modified = bitwise_any?(
                  xor,
                  BITMASKS[:kl_30],
                  BITMASKS[:kl_r],
                  BITMASKS[:kl_15],
                  BITMASKS[:kl_50]
                )
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

                case state[:ignition]
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
            end
          end
        end
      end
    end
  end
end
