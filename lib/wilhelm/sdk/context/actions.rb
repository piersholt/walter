# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Actions
        module Actions
          include Logging

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
