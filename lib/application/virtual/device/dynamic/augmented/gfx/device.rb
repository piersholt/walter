# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedGFX < AugmentedDevice
    include Capabilities::GFX
    include State

    PUBLISH = [
      MENU_GFX,
      SRC_SND, SRC_GFX,
      TEL_OPEN, GFX_STATUS, TEL_DATA, DSP_EQ,
      OBC_CONFIG, OBC_REQ,
      PING,
      COUNTRY_REQ, COUNTRY_REP,
      IGNITION_REQ, IGNITION_REP
    ].freeze

    SUBSCRIBE = [
      PING, PONG,
      TXT_MID, TXT_GFX, TXT_HUD, TXT_NAV,
      RAD_ALT, MENU_RAD,
      BMBT_A, BMBT_B
    ].freeze


    PROC = 'AugmentedGFX'

    def moi
      ident.upcase
    end

    def logger
      LogActually.gfx
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
      # logger.debug(moi) { "#handle_virtual_transmit(#{command_id})" }

      case command_id
      # when PING
      #   dependent = message.to
      #   logger.debug(moi) { "Depends on: #{dependent}" }
      # when PONG
      #   logger.debug(moi) { "Ready." }
      when MENU_GFX
        logger.info(moi) { "Menu GFX" }
        evaluate_menu_gfx(message.command)
      when SRC_GFX
        logger.info(moi) { "Source GFX" }
        # evaluate_menu_gfx(message.command)
      when SRC_SND
        logger.info(moi) { "Source GFX" }
        # evaluate_menu_gfx(message.command)
      end
    end

    def handle_virtual_receive(message)
      command_id = message.command.d
      return false unless subscribe?(command_id)
      # logger.unknown(moi) { "#handle_virtual_receive(#{command_id})" }

      case command_id
      when TXT_GFX
        logger.info(moi) { "Render 0x#{DataTools.d2h(TXT_GFX)}" }
        handle_draw_23(message.command)
      when MENU_RAD
        logger.info(moi) { "MENU_RAD 0x#{DataTools.d2h(MENU_RAD)}" }
        handle_menu_rad(message.command)
      when RAD_ALT
        logger.info(moi) { "RAD_ALT 0x#{DataTools.d2h(RAD_ALT)}" }
        handle_radio_alt(message.command)
      when TXT_NAV
        logger.info(moi) { "TXT_NAV 0x#{DataTools.d2h(TXT_NAV)}" }
        handle_draw_a5(message.command)
      end
    end
  end
end