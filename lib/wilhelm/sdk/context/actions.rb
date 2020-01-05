# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Actions
        module Actions
          include Logging

          # via Controls
          def shutdown
            logger.debug(stateful) { "#shutdown" }
            @state.shutdown(self)
          end
        end
      end
    end
  end
end
