# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        # GFX::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include Capabilities
          include State

          PROC = 'GFX::Augmented'

          PUBLISH = [
            PING, PONG,
            LCD_SET,
            COUNTRY_REQ, COUNTRY_REP,
            IGNITION_REQ, IGNITION_REP,
            TEL_OPEN, GFX_STATUS,
            INPUT,
            DSP_SET,
            OBC_VAR, OBC_BOOL,
            MENU_GFX,
            SRC_SND, SRC_GFX
          ].freeze

          SUBSCRIBE = [
            PING, PONG,
            TXT_MID, TXT_GFX, TXT_NAV,
            RAD_ALT, MENU_RAD
          ].freeze

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
            when LCD_SET
              logger.debug(moi) { "Tx: LCD_SET" }
              evaluate_lcd_set(message.command)
            when INPUT
              logger.debug(moi) { "Tx: Input (#{d2h(INPUT)})" }
              evaluate_input(message.command)
            when OBC_BOOL
              logger.debug(moi) { "Tx: OBC Boolean (#{d2h(OBC_BOOL)})" }
              evaluate_obc_bool(message.command)
            when MENU_GFX
              logger.debug(moi) { "Tx: Menu GFX (#{d2h(MENU_GFX)})" }
              evaluate_menu_gfx(message.command)
            when SRC_SND
              logger.debug(moi) { "Tx: Source SND (#{d2h(SRC_SND)})" }
              evaluate_src_snd(message.command)
            when SRC_GFX
              logger.debug(moi) { "Tx: Source GFX (#{d2h(SRC_GFX)})" }
              evaluate_src_gfx(message.command)
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            # logger.unknown(moi) { "#handle_virtual_receive(#{command_id})" }
            case command_id
            when TXT_GFX
              logger.debug(moi) { "Rx: TXT_GFX 0x#{d2h(TXT_GFX)}" }
              return false unless message.from == :rad
              handle_draw_23(message.command)
            when MENU_RAD
              logger.debug(moi) { "Rx: MENU_RAD 0x#{d2h(MENU_RAD)}" }
              handle_menu_rad(message.command)
            when RAD_ALT
              logger.debug(moi) { "Rx: RAD_ALT 0x#{d2h(RAD_ALT)}" }
              handle_radio_alt(message.command)
            when TXT_NAV
              logger.debug(moi) { "Rx: TXT_NAV 0x#{d2h(TXT_NAV)}" }
              return false unless message.from == :rad
              handle_draw_a5(message.command)
            when TXT_MID
              logger.debug(moi) { "Rx: TXT_MID 0x#{d2h(TXT_MID)}" }
              return false unless message.from == :rad
              handle_draw_21(message.command)
            end
          end
        end
      end
    end
  end
end
