# frozen_string_literal: true

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

        MOD_PROG = 'Telephone::LED'

        # green
        def connected
          logger.debug(MOD_PROG) { '#connected' }
          bus.tel.red(:off).green(:on).leds!
        end

        def disconnected
          logger.debug(MOD_PROG) { '#disconnected' }
          bus.tel.red(:on).green(:off).leds!
        end

        # yellow
        # attempt to begin connection operation
        def connect
          logger.debug(MOD_PROG) { '#connect' }
          bus.tel.green(:blink).leds!
        end

        # yellow blink
        # acknowledged operation via bluetooth service callback
        def connecting
          logger.debug(MOD_PROG) { '#connecting' }
          bus.tel.green(:blink).leds!
        end

        # red
        # attempt to begin disconnection operation
        def disconnect
          logger.debug(MOD_PROG) { '#disconnect' }
          bus.tel.red(:blink).leds!
        end

        # red blink
        # acknowledged operation via bluetooth service callback
        def disconnecting
          logger.debug(MOD_PROG) { '#disconnecting' }
          bus.tel.red(:blink).green(:off).leds!
        end
      end
    end
  end
end
