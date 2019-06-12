# frozen_string_literal: false

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

class Wilhelm::API
  # Controls object for vehicle API
  class Controls
    STATELESS = :stateless
    STATEFUL = :stateful

    include Singleton
    include Observable
    include Stateful
    include Listener

    attr_accessor :bus

    alias control_state state

    # HELPERS ----------------------------------------------------

    def logger
      LogActually.controls
    end

    def to_s
      'Controls'
    end

    def targets
      %i[mfl bmbt]
    end

    def default_state
      { mfl: {}, bmbt: {} }
    end
  end
end
