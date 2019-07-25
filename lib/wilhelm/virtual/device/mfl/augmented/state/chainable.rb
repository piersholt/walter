# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MFL
        class Augmented < Device::Augmented
          module State
            # Device::MFL::Augmented::State::Chainable state commands
            module Chainable
              include Observable
              include Constants
              include Virtual::Constants::Controls::MFL

              def log_state(delta, level = :debug)
                logger.public_send(level, moi) { delta }
              end

              def mode!(command_mode)
                case command_mode
                when :rad
                  mode_rad
                when :tel
                  mode_tel
                end
              end

              def mode_rad
                delta = { mode: MODE_RAD }
                state!(delta)
                log_state(delta)
                changed
                notify_observers(MFL_RT_RAD, state: state)
                self
              end

              def mode_tel
                delta = { mode: MODE_TEL }
                state!(delta)
                log_state(delta)
                changed
                notify_observers(MFL_RT_TEL, state: state)
                self
              end
            end
          end
        end
      end
    end
  end
end
