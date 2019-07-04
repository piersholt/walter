# frozen_string_literal: true

# Top level namespace
module Wilhelm
  module SDK
    class Context
      # Default Wilhelm logger
      class UserInterface
        module Constants
          include LogActually::ErrorOutput

          def logger
            LOGGER
          end
        end
      end
    end
  end
end
