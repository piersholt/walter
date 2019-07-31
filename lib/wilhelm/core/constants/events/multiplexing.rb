# frozen_string_literal: false

module Wilhelm
  module Core
    module Constants
      module Events
        # Core::Constants::Events::Multiplexing
        module Multiplexing
          MESSAGE_RECEIVED = :message_received
          MESSAGE_SENT = :message_sent
          PACKET_RECEIVED = :packet_received
          PACKET_ROUTABLE = :packet_routable

          LAYER_EVENTS = constants.map { |c| const_get(c) }
        end
      end
    end
  end
end
