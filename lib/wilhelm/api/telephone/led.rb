# frozen_string_literal: false

module Wilhelm
  module API
    class Telephone
      # Control of the BMBT/MID telephone status LEDs
      module LED
        # Yellow
        #   reflects state of the connect/disconnect operation
        #   on/steady: service has called remote operateion
        #   blink: remote operation acknowledged
        # Red
        #   connect/disconnect modifier
        #   contextualises connection operation as disconnection

        # green
        def connected
          bus.tel.red(:off).green(:on).leds!
        end

        def disconnected
          bus.tel.red(:on).green(:off).leds!
        end

        # yellow
        # attempt to begin connection operation
        def connect
          bus.tel.green(:blink).leds!
        end

        # red
        # attempt to begin disconnection operation
        def disconnect
          bus.tel.red(:blink).leds!
        end

        # yellow blink
        # acknowledged operation via bluetooth service callback
        def connecting
          bus.tel.green(:blink).leds!
        end

        # red blink
        # acknowledged operation via bluetooth service callback
        def disconnecting
          bus.tel.red(:blink).leds!
        end
      end
    end
  end
end
