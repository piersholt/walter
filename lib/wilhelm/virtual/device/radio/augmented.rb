# frozen_string_literal: true

module Wilhelm
  module Virtual
    # Comment
    class Device
      module Radio
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include State
          # include Retroactive
          include Actions
          include Notifications
          # include Capabilities::OnBoardMonitor
          include Capabilities

          PROC = 'AugmentedRadio'

          PUBLISH     = [PING, PONG, TXT_MID, TXT_GFX, TXT_NAV, CDC_REQ, MENU_RAD, RAD_LED, RAD_ALT]
          SUBSCRIBE = [PING, MFL_VOL, CDC_REP, BMBT_A, SRC_CTL, SRC_SND, MENU_GFX, TEL_DATA]

          def logger
            LOGGER
          end

          def publish?(command_id)
            PUBLISH.include?(command_id)
          end

          def subscribe?(command_id)
            SUBSCRIBE.include?(command_id)
          end

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)

            case command_id
            when PING
              dependent = message.to
              # logger.debug('Radio') { "Tx: Depends on: #{dependent}" }
              depend(dependent)
            when PONG
              # logger.debug('Radio') {Tx:  "Ready." }
              # seen
            when TXT_MID
              # logger.debug('Radio') {Tx:  "Drawing to MID!" }
            when TXT_GFX
              logger.debug('Radio') { "Tx: TXT_GFX 0x#{d2h(TXT_GFX)}" }
              # foreground
              evaluate_display_layout(message.command)
            when TXT_NAV
              # logger.debug('Radio') { "Tx: TXT_NAV 0x#{d2h(TXT_NAV)}" }
              # evaluate_nav_layout(message.command)
            when CDC_REQ
              # logger.debug('Radio') { "Tx: CDC_REQ 0x#{d2h(CDC_REQ)}!" }
              evaluate_cdc_request(message.command)
            when MENU_RAD
              logger.debug('Radio') { "Tx: MENU_RAD 0x#{d2h(MENU_RAD)}" }
              # background
              evaluate_menu_rad(message.command)
            when RAD_LED
              logger.debug('Radio') { "Tx: RAD_LED 0x#{d2h(RAD_LED)}!" }
              evaluate_radio_led(message.command)
            when RAD_ALT
              logger.debug('Radio') { "Tx: RAD_ALT 0x#{d2h(RAD_ALT)}" }
              evaluate_radio_alt(message.command)
            end

            # logger.unknown(PROC) { "Handle? From: #{message.from} Command: #{message.command.h}" }
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            # return super if command_id == PING
            # logger.debug(PROC) { "Handle? From: #{message.from} Command: #{message.command.h}" }

            case command_id
            when MFL_FUNC
              logger.debug(PROC) { "Rx: Handling: MFL-FUNC" }
              action_mfl_function(message)
            when BMBT_A
              logger.debug(PROC) { "Rx: Handling: BMBT-1" }
              handle_bmbt_1_button(message)
              action_bmbt_1_button(message)
            when BMBT_B
              # logger.debug(PROC) { "Rx: Handling BMBT-2 not implemented." }
            when SRC_CTL
              # logger.debug(PROC) { "Rx: Handling SRC_CTL not implemented." }
              # can get tape
            when SRC_SND
              # logger.debug(PROC) { "Rx: SRC_CTL not implemented." }
              # can get tape
              handle_source_sound(message.command)
            when MENU_GFX
              logger.debug(PROC) { "Rx: Handling: MENU_GFX"  }
              handle_menu_gfx(message.command)
            when TEL_DATA
              # logger.debug(PROC) { "Rx: Handling: TEL_DATA"  }
              # handle_tel_data(message.command)
            end
          rescue StandardError => e
            logger.error(self.class) { e }
            e.backtrace.each { |line| logger.error(self.class) { line } }
          end
        end
      end
    end
  end
end
