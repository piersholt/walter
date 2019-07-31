# frozen_string_literal: false

module Wilhelm
  module Core
    module Constants
      module Events
        # Core::Constants::Events::Interface
        module Interface
          BUS_OFFLINE = :offline
          BUS_ONLINE = :online
          BUS_BUSY = :busy
          BUS_IDLE = :idle
          BUS_ACTIVE = :active
          BYTE_RECEIVED = :byte_received

          INTERFACE_EVENTS = constants.map { |c| const_get(c) }
        end
      end
    end
  end
end
