# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    include API::RadioLED
    include State
    # include Retroactive
    include Actions
    include Notifications
    # include Capabilities::OnBoardMonitor
    include Capabilities::Radio

    PROC = 'AugmentedRadio'

    PUBLISH     = [PING, PONG, TXT_MID, TXT_GFX, TXT_NAV, CDC_REQ, MENU_RAD, RAD_LED, RAD_ALT]
    SUBSCRIBE = [PING, MFL_VOL, CDC_REP, BMBT_A, SRC_CTL, SRC_SND, MENU_GFX]

    def logger
      LogActually.rad
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
        logger.debug('Radio') { "Depends on: #{dependent}" }
        depend(dependent)
      when PONG
        logger.debug('Radio') { "Ready." }
        # seen
      when TXT_MID
        # logger.debug('Radio') { "Drawing to MID!" }
      when TXT_GFX
        logger.debug('Radio') { "Drawing to BMBT!" }
        # foreground
        evaluate_display_layout(message.command)
      when TXT_NAV
        logger.debug('Radio') { "Drawing to BMBT!" }
        # evaluate_nav_layout(message.command)
      when CDC_REQ
        logger.debug('Radio') { "CDC Request!" }
        evaluate_cdc_request(message.command)
      when MENU_RAD
        logger.debug('Radio') { "Menu Radio" }
        # background
        evaluate_menu_rad(message.command)
      when RAD_LED
        logger.debug('Radio') { "Radio LED!" }
        evaluate_radio_led(message.command)
      when RAD_ALT
        logger.debug('Radio') { "Radio SELECT/TONE" }
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
        logger.debug(PROC) { "Handling: MFL-FUNC" }
        action_mfl_function(message)
      when BMBT_A
        # logger.debug(PROC) { "BMBT-1 not implemented." }
        logger.debug(PROC) { "Handling: BMBT-1" }
        handle_bmbt_1_button(message)
        action_bmbt_1_button(message)
      when BMBT_B
        logger.debug(PROC) { "BMBT-2 not implemented." }
      when SRC_CTL
        logger.debug(PROC) { "SRC_CTL not implemented." }
        # can get tape
      when SRC_SND
        # logger.debug(PROC) { "SRC_CTL not implemented." }
        # can get tape
        handle_source_sound(message.command)
      when MENU_GFX
        logger.debug(PROC) { "Handling: MENU_GFX"  }
        handle_menu_gfx(message.command)
      end
    rescue StandardError => e
      logger.error(self.class) { e }
      e.backtrace.each { |line| logger.error(self.class) { line } }
    end
  end
end
