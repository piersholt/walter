# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Virtual::Command::RadioLED
        class RadioLED < Base
          def tape?
            led? == :tape
          end

          def off?
            led? == :off
          end

          def radio?
            led? == :radio
          end

          def on?
            led? == :on
          end

          OFF    = 0x00
          TAPE_A = (0x40..0x45)
          RADIO  = 0x48
          TAPE_B = (0x5a..0x5f)
          RESET  = 0x90
          ON     = 0xff

          def led?
            case led.value
            when TAPE_A
              :tape
            when RADIO
              :radio
            when OFF
              :off
            when TAPE_B
              :tape
            when RESET
              :reset
            when ON
              :on
            end
          end
        end
      end
    end
  end
end
