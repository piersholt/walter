# frozen_string_literal: false

module Wilhelm
  module Core
    module Constants
      module Events
        # Core::Constants::Events::Deprecated
        module Deprecated
          MESSAGE_DISPLAY = :message_display

          USER_EVENTS = constants.map { |c| const_get(c) }
        end
      end
    end
  end
end
