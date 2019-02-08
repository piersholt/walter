# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedGFX < AugmentedDevice
    include Capabilities::Ready
    include Capabilities::GFX
    include State

    PUBLISH = [
      MENU_GFX,
      SRC_SND, SRC_GFX,
      TEL_OPEN, GFX_STATUS, TEL_DATA, DSP_EQ,
      OBC_CONFIG, OBC_REQ,
      PING, PONG,
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
      when PING
        dependent = message.to
        # logger.debug(moi) { "Depends on: #{dependent}" }
        logger.debug(moi) { "Tx: PING (#{dependent})" }
        evaluate_ping(message.command)
      when PONG
        logger.debug(moi) { "Tx: PONG" }
        evaluate_pong(message.command)
      when MENU_GFX
        logger.debug(moi) { "Tx: Menu GFX (#{DataTools.d2h(MENU_GFX)})" }
        evaluate_menu_gfx(message.command)
      when SRC_GFX
        logger.debug(moi) { "Tx: Source GFX (#{DataTools.d2h(SRC_GFX)})" }
        evaluate_src_gfx(message.command)
      when SRC_SND
        # logger.debug(moi) { "Tx: Source SND (#{DataTools.d2h(SRC_SND)})" }
        # evaluate_menu_gfx(message.command)
      when OBC_REQ
        logger.debug(moi) { "Tx: OBC Req. (#{DataTools.d2h(OBC_REQ)})" }
        evaluate_obc_req(message.command)
      end
    end

    def handle_virtual_receive(message)
      command_id = message.command.d
      return false unless subscribe?(command_id)
      # logger.unknown(moi) { "#handle_virtual_receive(#{command_id})" }

      case command_id
      when TXT_GFX
        logger.debug(moi) { "Rx: TXT_GFX 0x#{DataTools.d2h(TXT_GFX)}" }
        handle_draw_23(message.command)
      when MENU_RAD
        logger.debug(moi) { "Rx: MENU_RAD 0x#{DataTools.d2h(MENU_RAD)}" }
        handle_menu_rad(message.command)
      when RAD_ALT
        logger.debug(moi) { "Rx: RAD_ALT 0x#{DataTools.d2h(RAD_ALT)}" }
        handle_radio_alt(message.command)
      when TXT_NAV
        logger.debug(moi) { "Rx: TXT_NAV 0x#{DataTools.d2h(TXT_NAV)}" }
        handle_draw_a5(message.command)
      when TXT_MID
        logger.debug(moi) { "Rx: TXT_MID 0x#{DataTools.d2h(TXT_MID)}" }
        handle_draw_21(message.command)
      when BMBT_A
        logger.unknown(moi) { "Rx: BMBT_A 0x#{DataTools.d2h(BMBT_A)}" }
        handle_bmbt_1_button(message.command)
      when BMBT_B
        logger.unknown(moi) { "Rx: BMBT_B 0x#{DataTools.d2h(BMBT_B)}" }
        handle_bmbt_2_button(message.command)
      end
    end
  end
end
