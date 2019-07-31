# frozen_string_literal: false

module Wilhelm
  module Core
    module Constants
      module Events
        # Core::Constants::Events::Application
        module Application
          STATUS_REQUEST = :thread_status_request
          EXIT = :exit

          APP_EVENTS = constants.map { |c| const_get(c) }
        end
      end
    end
  end
end
