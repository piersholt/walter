# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      # Comment
      module State
        include Observable

        def offline!
          LOGGER.warn(PROC) { "IO stream is file => Bus Offline!" }
          changed
          notify_observers(Constants::Events::BUS_OFFLINE, self.class)
        end

        def online!
          LOGGER.warn(PROC) { "IO stream is tty => Bus Online!" }
          changed
          notify_observers(Constants::Events::BUS_ONLINE, self.class)
        end
      end
    end
  end
end
