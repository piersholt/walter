# frozen_string_literal: true

class Virtual
  class AugmentedMFL < AugmentedDevice
    module State
      # Comment
      module Sent
        # include Events

        # 0x3B
        def handle_mfl_func_button(command)
          logger.debug(moi) { "MFL_FUNC -> #{command.pretty}" }
          return mode!(command.mode?) if command.rt?
          notify_of_button(command)
        end

        # 0x32
        def handle_mfl_vol_button(command)
          logger.debug(moi) { "MFL_VOL -> #{command.pretty}" }
          changed
          notify_observers(:button, button: command.button, state: :mfl_null, source: :mfl)
        end

        private

        def notify_of_button(command)
          changed
          notify_observers(:button, button: command.button, state: command.state, source: :mfl)
        end
      end
    end
  end
end