module Wolfgang
  class Audio
    include Logger
    include Messaging::API

    attr_reader :state

    def initialize
      @state = Disabled.new
    end

    # PROPERTIES

    def target
      @target ||= Target.new
    end

    def player
      @player ||= Player.new
    end

    # STATES --------------------------------------------------------

    def change_state(new_state)
      logger.info(self.class) { "state change => #{new_state.class}" }
      @state = new_state
    end

    def enable
      @state.enable(self)
    end

    def on
      @state.on(self)
    end

    # NOTIFICATIONS (TARGET) -------------------------------------------------

    def player_added(properties)
      @state.player_added(self, properties)
    end

    def player_changed(properties)
      @state.player_changed(self, properties)
    end

    def player_removed(properties)
      @state.player_removed(self, properties)
    end

    # NOTIFICATIONS (PLAYER) -------------------------------------------------

    def everyone(properties)
      @state.everyone(self, properties)
    end

    def track_change(properties)
      @state.track_change(self, properties)
    end

    def track_start(properties)
      @state.track_start(self, properties)
    end

    def track_end(properties)
      @state.track_end(self, properties)
    end

    def position(properties)
      @state.position(self, properties)
    end

    def status(properties)
      @state.status(self, properties)
    end

    def repeat(properties)
      @state.repeat(self, properties)
    end

    def shuffle(properties)
      @state.shuffle(self, properties)
    end
  end
end
