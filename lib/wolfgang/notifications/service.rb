# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    include LogActually::ErrorOutput
    attr_accessor :listener, :handler, :bus

    include Logger

    def initialize(bus)
      @bus = bus
      @state = Inactive.new
    end

    def start
      logger.debug(self.class) { '#start' }
      @state.start(self)
    end

    def stop
      logger.debug(self.class) { '#stop' }
      @state.stop(self)
    end

    def change_state(new_state)
      logger.info(self.class) { "state change => #{new_state.class}" }
      @state = new_state
    end
  end
end
