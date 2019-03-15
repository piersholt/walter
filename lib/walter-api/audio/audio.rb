# frozen_string_literal: false

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

class Vehicle
  # Audio object for vehicle API
  class Audio
    include Singleton
    include Observable

    attr_accessor :bus

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
  end
end
