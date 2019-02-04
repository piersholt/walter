# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Wolfgang Service
  class Service
    include Logger

    SERVICES = [
      { name: 'Bluetooth', action: :bluetooth_index },
      { name: 'Audio', action: :audio_index }
    ].freeze

    attr_accessor :commands, :notifications, :bus, :manager, :audio

    def initialize
      @state = Offline.new
    end

    def services
      SERVICES
    end

    def change_state(new_state)
      logger.info(self.class) { "state change => #{new_state.class}" }
      @state = new_state
    end

    def ui(force = false)
      case force
      when true
        Wolfgang::UserInterface.new(self)
      when false
        @ui ||= Wolfgang::UserInterface.new(self)
      end
    end

    def open
      logger.debug(self.class) { '#open' }
      @state.open(self)
    end

    def close
      logger.debug(self.class) { '#close' }
      @state.close(self)
    end

    def alive?
      @state.alive?(self)
    end

    def online!
      @state.online!(self)
    end

    def offline!
      @state.offline!(self)
    end

    def notifications!
      @state.notifications!(self)
    end

    def manager!
      @state.manager!(self)
    end

    def audio!
      @state.audio!(self)
    end
  end
end
