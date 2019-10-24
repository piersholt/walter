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

              # 0x32 VOLUME
              # @note 0x32 used by both MFL and BMBT
              def evaluate_mfl_vol_button(command)
                logger.debug(moi) { "MFL_VOL -> #{command.pretty}" }
                # NOTE: volume handled by recipient, i.e. TEL, or RAD
                # notify_of_button(command)
              end

              # 0x3B MFL-FUNC
              def evaluate_mfl_func_button(command)
                logger.debug(moi) { "MFL_FUNC -> #{command.pretty}" }
                return mode!(command.mode?) if command.rt?
                # NOTE: volume handled by recipient, i.e. TEL, or RAD
                # notify_of_button(command)
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
