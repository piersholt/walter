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
          def shutdown(toggle)
            logger.debug(self) { "#shutdown(#{toggle})" }
            @state.shutdown(self, toggle)
          end
        end
      end
    end
  end
end
