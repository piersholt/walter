# frozen_string_literal: true

class Virtual
  class AugmentedBMBT < AugmentedDevice
    module State
      # Comment
      module Sent
        include Events

        def handle_bmbt_1_button(command)
          logger.debug(moi) { "BMBT 1 -> #{command.pretty}" }
          return false if command.is?(BMBT_MENU) && (command.press? || command.hold?)
          changed
          notify_observers(command.button, state: command.state)
        end
      end
    end
  end
end
