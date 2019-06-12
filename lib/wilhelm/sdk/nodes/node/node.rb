# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  # Comment
  class Node
    include Logging
    include Constants
    include State
    include Messaging::API
    include Observable

    attr_reader :state

    def initialize(nickname = DEFAULT_NICKNAME)
      @nickname = nickname
      @state = Offline.new
    end

    # METHODS -------------------------------------------------------------

    def connect
      logger.debug(NODE) { '#connect' }
      @state.connect(self)
    end

    def disconnect
      logger.debug(NODE) { '#disconnect' }
      @state.disconnect(self)
    end

    def online!
      @state.online!(self)
    end

    def establishing!
      @state.establishing!(self)
    end

    def offline!
      @state.offline!(self)
    end

    def alive?
      LogActually.alive.debug(NODE) { '#alive?' }
      @state.alive?(self)
    end

    def ping_callback
      LogActually.alive.debug(NODE) { '#ping_callback' }
      @state.ping_callback(self)
    end

    alias open connect
    alias close disconnect
  end
end
