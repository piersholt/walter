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

    # Yellow
    #   reflects state of the connect/disconnect operation
    #   on/steady: service has called remote operateion
    #   blink: remote operation acknowledged
    # Red
    #   connect/disconnect modifier
    #   contextualises connection operation as disconnection

    # yellow
    # attempt to begin connection operation
    def connect
      bus.tel.red(:off).yellow(:on).green(:blink).leds!
    end

    # yellow blink
    # acknowledged operation via bluetooth service callback
    def connecting
      bus.tel.yellow(:blink).green(:blink).leds!
    end

    # green
    def connected
      bus.tel.red(:off).yellow(:off).green(:on).leds!
    end

    # red
    # attempt to begin disconnection operation
    def disconnect
      bus.tel.yellow(:on).red(:blink).green(:off).leds!
    end

    # red blink
    # acknowledged operation via bluetooth service callback
    def disconnecting
      bus.tel.yellow(:blink).red(:blink).green(:off).leds!
    end

    def disconnected
      bus.tel.yellow(:off).green(:off).red(:on).leds!
    end
  end
end
