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

          def led?
            case led.value
            when (0x40..0x45)
              :tape
            when 0x48
              :radio
            when 0x00
              :off
            when (0x5a..0x5f)
              :tape
            when 0x90
              :reset
            when 0xff
              :on
            end
          end
        end
      end
    end
  end
end
