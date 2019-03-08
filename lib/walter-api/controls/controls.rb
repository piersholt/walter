# frozen_string_literal: false

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

class Vehicle
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

    # TODO: API
    # accessor for each set of buttons, i.e. bmbt, mfl
    # nested accessor for each button
    # methods to:
    #   press
    #   hold (simulate toggle)
    #   release
    # macros to:
    #   press_and_release(interval)
    #   short_press (simulate press -> release)
    #   long_press  (simulate press -> hold -> release)
  end
end
