# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class Device
      module MFL
        # Comment
        class Augmented < Device::Augmented
          module State
            # Chianable state commands
            module Chainable
              include Constants
              include Virtual::Constants::Buttons::BMBT
              include Observable

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
