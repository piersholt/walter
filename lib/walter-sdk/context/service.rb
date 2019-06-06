# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Wolfgang Service
  class ApplicationContext
    include Logging
    include Constants
    include Observable
    include Messaging::API
    include Controls
    include Nodes

    attr_reader :state

    attr_accessor :commands, :notifications, :manager, :audio
    attr_writer :ui

    def initialize
      @state = Offline.new
      Client.wolfgang.pi
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

    # METHODS -------------------------------------------------------------

    def alive?
      @state.alive?(self)
    end

    alias open online!
    alias close offline!

    # APPLICATION CONTEXT -----------------------------------------------------

    def ui
      semaphore.synchronize do
        @ui
      end
    end

    def notifications!
      @state.notifications!(self)
    end

    def ui!
      @state.ui!(self)
    end

    # SERVICES ----------------------------------------------------------------

    def manager!
      @state.manager!(self)
    end

    def audio!
      @state.audio!(self)
    end

    def services
      [manager, audio]
    end

    private

    def semaphore
      @semaphore ||= Mutex.new
    end
  end
end
