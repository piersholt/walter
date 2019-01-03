module Wolfgang
  class Audio
    include Logger

    def initialize
      @state = Disabled.new
    end

    def change_state(new_state)
      logger.info(self.class) { "state change => #{new_state.class}" }
      @state = new_state
    end

    def enable
      @state.enable(self)
    end
  end
end
