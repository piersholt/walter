# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        class Augmented < Device::Augmented
          module State
            # LCM::Augmented::State::Backlight
            module Backlight
              include Wilhelm::Helpers::DataTools
              include Wilhelm::Helpers::Bitwise
              include Virtual::Constants::Events::LCM
              include Constants

              def backlight_off?
                bitwise_all?(state[:backlight], BITMASKS[:backlight_off])
              end

              def backlight?
                !backlight_off?
              end

              def backlight
                return 0 unless backlight?
                state[:backlight]&.fdiv(0xff - 0xf)&.round(2)
              end

              # 0x5C 58G
              def backlight!(value)
                xor = state[:backlight] ^ value
                logger.debug(ident) { "Backlight: #{d2b(state[:backlight], true, true)} XOR #{d2b(value, true, true)} = #{d2b(xor, true, true)}" }
                modified = bitwise_any?(xor, BITMASKS[:backlight_off])
                logger.debug(ident) { "Backlight modified? #{modified}" }

                state[:backlight] = value
                return state[:backlight] unless modified

                case value
                when BACKLIGHT_OFF
                  changed
                  notify_observers(BACKLIGHT_OFF, device: ident)
                else
                  changed
                  notify_observers(BACKLIGHT_ON, device: ident, level: value, percentage: backlight)
                end
              end
            end
          end
        end
      end
    end
  end
end
