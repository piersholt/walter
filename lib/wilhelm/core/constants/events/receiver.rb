# frozen_string_literal: false

module Wilhelm
  module Core
    module Constants
      module Events
        # Core::Constants::Events::Receiver
        module Receiver
          FRAME_RECEIVED = :frame_received
          FRAME_FAILED = :frame_failed
          FRAME_SENT = :frame_sent

          RECEIVER_EVENTS = constants.map { |c| const_get(c) }
        end
      end
    end
  end
end
