# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Comment
      module Logging
        include Constants
        include LogActually::ErrorOutput

        def to_s
          "Manager (#{state_string})"
        end

        def nickname
          :manager
        end

        def state_string
          case state
          when On
            'Available'
          when Enabled
            'Pending'
          when Disabled
            'Disabled'
          else
            state.class
          end
        end

        def logger
          LogActually.services
        end
      end
    end
  end
end
