# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Wolfgang Service
  class Service
    include Logger
    include Observable
    include Messaging::API

    attr_reader :state

    attr_accessor :commands, :notifications, :bus, :manager, :audio

    def initialize
      @state = Offline.new
      Client.pi
    end

    def nickname
      :wolfgang
    end

    # STATES -------------------------------------------------------------

    def change_state(new_state)
      logger.info(WOLFGANG) { "state change => #{new_state.class}" }
      @state = new_state
      changed
      notify_observers(state)
      @state
    end

    def online!
      @state.online!(self)
    end

    def offline!
      @state.offline!(self)
    end

    def establishing!
      @state.establishing!(self)
    end

    def state_string
      case state
      when Online
        'Online'
      when Establishing
        'Establishing'
      when Offline
        'Offline'
      else
        state.class
      end
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

    def services
      [manager, audio]
    end

    def ui(reset = false)
      logger.unknown(WOLFGANG) { '#ui' }
      case reset
      when true
        create_ui
      when false
        @ui ||= create_ui
      end
    end

    def ui!
      logger.unknown(WOLFGANG) { '#ui!' }
      ui(true)
    end

    def create_ui
      logger.unknown(WOLFGANG) { '#create_ui' }
      Wolfgang::UserInterface.new(self)
    end
  end
end
