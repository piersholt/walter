# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Logging
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          # Issue with change_state notification
          # State classes use Logging from service,
          # but have no state variable.. causing #stateful to error
          return stateful if self.respond_to?(:state)
          super()
        end

        def nickname
          :manager
        end

        def stateful
          "Manager (#{state_string})"
        end

        def state_string
          case state
          when Disabled
            MANAGER_STATE_DISABLED
          when Pending
            MANAGER_STATE_PENDING
          when On
            MANAGER_STATE_ON
          else
            state.class
          end
        end

        def logger
          LogActually.manager
        end
      end
    end
  end
end
