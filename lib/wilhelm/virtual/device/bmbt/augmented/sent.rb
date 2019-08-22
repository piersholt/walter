# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        class Augmented < Device::Augmented
          # BMBT::Augmented::Sent
          module Sent
            include Virtual::Constants::Controls::BMBT
            include Virtual::Constants::Events::BMBT

            # 0x32 VOLUME
            def evaluate_mfl_vol_button(command)
              logger.debug(moi) { "MFL VOL -> #{command.pretty}" }
              # notify_of_button(command)
            end

            # 0x48 BMBT-BTN
            def evaluate_bmbt_1_button(command)
              logger.debug(moi) { "BMBT 1 -> #{command.pretty}" }
              return false if command.is?(BMBT_MENU) && (command.press? || command.hold?)
              notify_of_button(command)
            end

            # 0x49 BMBT-DIAL
            def evaluate_bmbt_2_button(command)
              logger.debug(moi) { "BMBT B -> #{command.pretty}" }
              notify_of_button(command)
            end

            private

            def notify_of_button(command)
              changed
              notify_observers(BMBT_CONTROL, control: command.button, state: command.state, source: ident)
            end
          end
        end
      end
    end
  end
end
