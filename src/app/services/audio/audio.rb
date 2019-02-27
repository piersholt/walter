# frozen_string_literal: true

module Wolfgang
  # Comment
  class Audio
    include Logger
    include Messaging::API
    include Observable

    attr_reader :state

    def initialize
      @state = Disabled.new
    end

    def to_s
      "Audio (#{state_string})"
    end

    def nickname
      :audio
    end

    # STATES --------------------------------------------------------

    def change_state(new_state)
      logger.info(AUDIO) { "state change => #{new_state.class}" }
      @state = new_state
      changed
      notify_observers(@state)
      @state
    end

    def enable
      @state.enable(self)
    end

    def disable
      @state.disable(self)
    end

    def on
      @state.on(self)
    end

    def state_string
      case state
      when On
        'On'
      when Enabled
        'Enabled'
      when Disabled
        'Disabled'
      else
        state.class
      end
    end

    # PROPERTIES ------------------------------------------------------------------------

    def target
      @target ||= Target.new
    end

    def player
      @player ||= Player.new
    end


    # NOTIFICATIONS (TARGET) -------------------------------------------------

    def addressed_player(properties)
      @state.addressed_player(self, properties)
    end

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

    # @deprecated
    def everyone(properties)
      logger.warn(AUDIO) { '#everyone is deprecated!' }
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

    # API

    def player?
      player!(player_callback(self))
    end

    def player_callback(context)
      proc do |reply, error|
        begin
          if reply
            logger.info(AUDIO) { "#player_callback(#{reply})" }
            # logger.info(AUDIO) { "reply => #{reply}" }
            context.public_send(reply.name, reply.properties)
          else
            logger.warn(AUDIO) { "Error! (#{error})" }
            # context.offline!
          end
        rescue StandardError => e
          logger.error(AUDIO) { e }
          e.backtrace.each { |line| logger.error(AUDIO) { line } }
          context.change_state(Disabled.new)
        end
      end
    end
  end
end
