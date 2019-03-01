# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedMFL < AugmentedDevice
    module State
      # Comment
      module Sent
        # include Events

        def handle_mfl_func_button(command)
          logger.debug(moi) { "MFL_FUNC -> #{command.pretty}" }
          return notify_of_mode_change(command) if command.rt?
          notify_of_button(command)
        end

        def handle_mfl_vol_button(command)
          logger.debug(moi) { "MFL_VOL -> #{command.pretty}" }
          notify_of_button(command)
        end

        private

        def notify_of_button(command)
          changed
          notify_observers(command.button, state: command.state)
        end
      end
    end
  end
end
