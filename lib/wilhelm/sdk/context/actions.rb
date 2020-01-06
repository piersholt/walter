# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Actions
        module Actions
          include Logging

          def load_context
            logger.debug(LOGGER_NAME) { '#load_context()' }
            @state.load_context(self)
          end

          # via Controls
          def shutdown(toggle = :on)
            logger.debug(self) { "#shutdown(#{toggle})" }
            case toggle
            when :on
              schedule_shutdown(1)
            when :off
              false
            end
          end

          # @todo command should be via env. conf.
          def schedule_shutdown(time = 1)
            logger.warn(self) { `/usr/bin/sudo /sbin/shutdown -h #{time}` }
          end
        end
      end
    end
  end
end
