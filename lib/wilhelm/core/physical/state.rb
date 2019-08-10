# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      # Core::Interface::State
      module State
        include Observable

        def offline!
          LOGGER.info(PROC) { "IO stream is #{self.class.name} => Bus Offline!" }
          changed
          notify_observers(Constants::Events::BUS_OFFLINE, self.class)
        end

        def online!
          LOGGER.info(PROC) { "IO stream is #{self.class.name} => Bus Online!" }
          changed
          notify_observers(Constants::Events::BUS_ONLINE, self.class)
        end
      end
    end
  end
end
