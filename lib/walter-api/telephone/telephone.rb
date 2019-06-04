# frozen_string_literal: false

class Vehicle
  # Telephone object for vehicle API
  class Telephone
    include Singleton
    include Observable

    attr_accessor :bus

    def logger
      LogActually.telephone
    end

    def to_s
      'Telephone'
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
  end
end
