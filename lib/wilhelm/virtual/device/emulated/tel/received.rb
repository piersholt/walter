# frozen_string_literal: true

module Wilhelm
  class Virtual
    class SimulatedTEL < EmulatedDevice
      # Comment
      module Received
        include Capabilities::Telephone::Constants

        # Piggyback off the radio announce to annunce
        def handle_announce(message)
          # logger.warn('SimulatedTEL') { "handling pong: #{message.from}" }
          # logger.warn('SimulatedTEL') { "message.from?(:rad) => #{message.from?(:rad)}" }

          return false unless message.from?(:gfx)
          return false unless message.command.status.value == ANNOUNCE
          logger.info(PROC) { "GFX has announced. Piggybacking (sic)" }
          ready
          true
        end

        def handle_gfx_status(message)
          logger.debug(PROC) { "Mock: handling GFX status..." }
          if message.command.status.value == STATUS_CLEAR
            logger.debug(PROC) { "Mock: GFX status clear!" }
            release_pending_render
          elsif message.command.status.value == STATUS_SUCCESS
            logger.debug(PROC) { "Mock: GFX status success!" }
            clear_retry
          elsif message.command.status.value == STATUS_HOME_SUCCESS
            logger.debug(PROC) { "Mock: GFX menu status success!" }
            clear_retry
          elsif message.command.status.value == STATUS_ERROR
            logger.debug(PROC) { "Mock: GFX status error!" }
            release_pending_retry
          end
        end

        def handle_data_request(message)
          logger.debug(PROC) { "Mock: handling telephone data request..." }
          # source = message.command.source
          # case source
          # when SOURCE_INFO
          #   handle_info(message)
          # when SOURCE_DIAL
          #   handle_dial(message)
          # when SOURCE_DIR
          #   directory(message)
          # when SOURCE_TOP
          #   handle_top(message)
          # end
          source = message.command.source.value
          function = message.command.function.value
          action = message.command.action.value
          case action
          when ACTION_DIAL_OPEN
            mid(m1: DRAW_DIAL, m2: MID_DEFAULT, m3: 0x00, chars: [])
          when ACTION_DIR_OPEN
            delegate_directory(action)
          when ACTION_DIR_BACK
            delegate_directory(action)
          when ACTION_DIR_FORWARD
            delegate_directory(action)
          when ACTION_INFO_OPEN
            delegate_info
          end
        end

        def handle_tel_open(message)
          logger.debug(PROC) { "Mock: handling telephone tel open request..." }
          # delegate_favourites
          mid(m1: DRAW_DIAL, m2: MID_DEFAULT, m3: 0x00, chars: [])
        end

        private

        # @deprecated
        def ready
          logger.warn(PROC) { '#ready is deprecated!' }
          logger.debug(PROC) { 'Telephone ready macro!' }
          leds(:off)
          leds!
          power!(OFF)
          status!
          announce
          sleep(0.25)
          power!(ON)
          status!
          # tel_led(LED_ALL)
          # bluetooth_pending
        end

        # @deprecated
        def tel_state(telephone_state = TEL_OFF)
          logger.warn(PROC) { '#tel_state is deprecated!' }
          status(status: telephone_state)
        end
      end
    end
  end
end
