# frozen_string_literal: true

module Wolfgang
  class Manager
    # Comment
    module Logging
      include Constants

      def to_s
        "Manager (#{state_string})"
      end

      def nickname
        :manager
      end

      def state_string
        case state
        when On
          'On'
        when Enabled
          'Enabled'
        when Disabled
          'Disabled'
        else
          state.class
        end
      end

      def logger
        LogActually.manager_service
      end
    end
  end
end
