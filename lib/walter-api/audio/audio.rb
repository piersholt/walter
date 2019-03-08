# frozen_string_literal: false

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

class Vehicle
  # Audio object for vehicle API
  class Audio
    include Singleton
    include Observable
    # include Stateful
    # include Listener

    attr_accessor :bus

    # HELPERS ----------------------------------------------------

    def logger
      LogActually.audio
    end

    def to_s
      'Audio'
    end

    def on
      bus.rad.led_on
    end

    def off
      bus.rad.led_off
    end

    def power
      case bus.bmbt.power?
      when false
        bus.rad.led_on
      when true
        bus.rad.led_off
      end
    end

    # def targets
    #   %i[mfl bmbt]
    # end

    # def default_state
    #   { mfl: {}, bmbt: {} }
    # end

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
