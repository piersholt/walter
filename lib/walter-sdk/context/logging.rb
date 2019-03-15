# frozen_string_literal: true

module Wolfgang
  class Service
    # Comment
    module Logging
      include Constants

      def to_s
        "Service (#{state_string})"
      end

      def nickname
        :wolfgang
      end

      def state_string
        case state
        when Online
          'Online'
        when Establishing
          'Establishing'
        when Offline
          'Offline'
        else
          state.class
        end
      end

      def logger
        LogActually.wolfgang
      end
    end
  end
end
