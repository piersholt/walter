# frozen_string_literal: true

# Top level namespace
module Wolfgang
  # Wolfgang Service
  class Service
    include Logging
    include Constants
    include Observable
    include Messaging::API
    include Controls

    attr_reader :state

    attr_accessor :commands, :notifications, :manager, :audio
    attr_writer :ui

    def initialize
      @state = Offline.new
      Client.pi
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

    def reply_block(context)
      proc do |reply, error|
        begin
          if reply
            logger.info(WOLFGANG_OFFLINE) { 'Online!' }
            context.online!
          elsif error == :timeout
            logger.warn(WOLFGANG_ONLINE) { "Timeout!" }
            context.establishing!
          elsif error == :down
            logger.warn(WOLFGANG_ONLINE) { "Error!" }
            context.offline!
          end
        rescue StandardError => e
          logger.error(WOLFGANG_OFFLINE) { e }
          e.backtrace.each { |line| logger.error(WOLFGANG_OFFLINE) { line } }
          context.change_state(Offline.new)
        end
      end
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

    def ui!
      @state.ui!(self)
    end

    def ui
      Mutex.new.synchronize do
        @ui
      end
    end

    # USER INTERFACE --------------------------------------------------------

    def services
      [manager, audio]
    end

    # def ui!
    #   Mutex.new.synchronize do
    #     LogActually.ui.debug(WOLFGANG) { "#ui (#{Thread.current})" }
    #     @ui ||= create_ui
    #   end
    # end

    # alias ui ui!

    # def ui(reset = false)
    #   logger.debug(WOLFGANG) { '#ui' }
    #   case reset
    #   when true
    #     create_ui
    #   when false
    #     @ui ||= create_ui
    #   end
    # end

    # def ui!
    #   logger.debug(WOLFGANG) { '#ui!' }
    #   ui(true)
    # end
  end
end
