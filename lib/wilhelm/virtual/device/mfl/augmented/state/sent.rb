# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MFL
        class Augmented < Device::Augmented
          module State
            # MFL::Augmented::State::Sent
            module Sent
              include Virtual::Constants::Events::MFL

              # 0x3B
              def handle_mfl_func_button(command)
                logger.debug(moi) { "MFL_FUNC -> #{command.pretty}" }
                return mode!(command.mode?) if command.rt?
                notify_of_button(command)
              end

              # 0x32
              def handle_mfl_vol_button(command)
                logger.debug(moi) { "MFL_VOL -> #{command.pretty}" }
                notify_of_button(command)
              end

              private

              def notify_of_button(command)
                changed
                notify_observers(MFL_CONTROL, control: command.button, state: command.state, source: ident)
              end
            end
          end
        end
      end
    end
  end
end
