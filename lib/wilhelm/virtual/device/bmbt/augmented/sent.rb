# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        class Augmented < Device::Augmented
          # BMBT::Augmented::Sent
          module Sent
            include Wilhelm::Virtual::Constants::Buttons::BMBT

            # 0x48
            def evaluate_bmbt_1_button(command)
              logger.debug(moi) { "BMBT 1 -> #{command.pretty}" }
              return false if command.is?(BMBT_MENU) && (command.press? || command.hold?)
              notify_of_button(command)
            end

            # 0x49
            def evaluate_bmbt_2_button(command)
              logger.debug(moi) { "BMBT B -> #{command.pretty}" }
              notify_of_button(command)
            end

            # 0x32
            def evaluate_mfl_vol_button(command)
              logger.debug(moi) { "MFL VOL -> #{command.pretty}" }
              notify_of_button(command)
            end

            private

            def notify_of_button(command)
              changed
              notify_observers(:button, button: command.button, state: command.state, source: :bmbt)
            end
          end
        end
      end
    end
  end
end
