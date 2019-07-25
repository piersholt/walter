# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Logging
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          stateful
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
          when Enabled
            MANAGER_STATE_ENABLED
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
