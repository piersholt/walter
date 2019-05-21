# frozen_string_literal: true

class Virtual
  class AugmentedBMBT < AugmentedDevice
    # Comment
    module Sent
      include Events

      # 0x48
      def handle_bmbt_1_button(command)
        logger.debug(moi) { "BMBT 1 -> #{command.pretty}" }
        return false if command.is?(BMBT_MENU) && (command.press? || command.hold?)
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