# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Wolfgang Service
  class Service
    include Logger
    include Messaging::API

    attr_accessor :commands, :notifications, :bus, :manager, :audio

    def initialize
      @state = Offline.new
      Client.pi
    end

    # STATES -------------------------------------------------------------

    def change_state(new_state)
      logger.info(WOLFGANG) { "state change => #{new_state.class}" }
      @state = new_state
    end

    def online!
      @state.online!(self)
    end

    def offline!
      @state.offline!(self)
    end

    # METHODS -------------------------------------------------------------

    def open
      logger.debug(WOLFGANG) { '#open' }
      @state.open(self)
    end

    def close
      logger.debug(WOLFGANG) { '#close' }
      @state.close(self)
    end

    def alive?
      @state.alive?(self)
    end

    # SERVICES -------------------------------------------------------------

    def notifications!
      @state.notifications!(self)
    end

    def manager!
      @state.manager!(self)
    end

    def audio!
      @state.audio!(self)
    end

    # USER INTERFACE --------------------------------------------------------

    SERVICES = [
      { name: 'Bluetooth', action: :bluetooth_index },
      { name: 'Audio', action: :audio_index }
    ].freeze

    def services
      SERVICES
    end

    def ui(reset = false)
      case reset
      when true
        create_ui
      when false
        @ui ||= create_ui
      end
    end

    def ui!
      ui(true)
    end

    def create_ui
      Wolfgang::UserInterface.new(self)
    end
  end
end
