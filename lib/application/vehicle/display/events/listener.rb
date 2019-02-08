# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module Listener
      include Events
      NAME = 'Listener'

      def update(event, properties = {})
        case event
        when :header_cache
          header_cache(properties)
        when :header_write
          header_write(properties)
        when :menu_cache
          menu_cache(properties)
        when :menu_write
          menu_write(properties)
        when GFX_PING
          LogActually.alive.debug(NAME) { "#update(#{GFX_PING})" }
          ping
        when GFX_ANNOUNCE
          logger.debug(NAME) { "#update(#{GFX_ANNOUNCE})" }
          announce
        when GFX_MONITOR_ON
          logger.debug(NAME) { "#update(#{GFX_MONITOR_ON})" }
          monitor_on
        when GFX_MONITOR_OFF
          logger.debug(NAME) { "#update(#{GFX_MONITOR_OFF})" }
          monitor_off
        when GFX_OBC_REQ
          logger.unknown(NAME) { "#update(#{GFX_OBC_REQ})" }
          obc_request
        when INPUT_MENU
          logger.unknown(NAME) { "#update(#{INPUT_MENU})" }
          input_menu
        when INPUT_AUX_HEAT
          logger.unknown(NAME) { "#update(#{INPUT_AUX_HEAT})" }
          input_aux_heat
        when INPUT_CONFIRM
          logger.unknown(NAME) { "#update(#{INPUT_CONFIRM}, #{properties || nil})" }
          input_confirm(properties)
        when RADIO_LAYOUT_RADIO
          # logger.unknown(NAME) { RADIO_LAYOUT_RADIO }
        when RADIO_LAYOUT_CDC
          # logger.unknown(NAME) { RADIO_LAYOUT_CDC }
        when RADIO_LAYOUT_TAPE
          # logger.unknown(NAME) { RADIO_LAYOUT_TAPE }
        when RADIO_LAYOUT_DIGITAL
          # logger.unknown(NAME) { RADIO_LAYOUT_DIGITAL }
        when GFX_IDLE
          # logger.unknown(NAME) { GFX_IDLE }
          # change_state(Available.new)
        when GFX_BUSY
          # logger.unknown(NAME) { GFX_BUSY }
          # change_state(Busy.new)
        when INPUT_SELECT
          logger.unknown(NAME) { "#update(#{INPUT_SELECT}, #{properties})" }
          input_select(properties)
        when INPUT_CONFIRM_PRESS
          # logger.debug(NAME) { INPUT_CONFIRM_SELECT }
        when INPUT_CONFIRM_HOLD
          # logger.unknown(NAME) { INPUT_CONFIRM_HOLD }
        when INPUT_CONFIRM_RELEASE
          # logger.unknown(NAME) { INPUT_CONFIRM_RELEASE }
        when INPUT_LEFT
          # logger.unknown(NAME) { INPUT_LEFT }
          # input_left(properties[:value])
        when INPUT_RIGHT
          # logger.unknown(NAME) { INPUT_RIGHT }
          # input_right(properties[:value])
        when RADIO_BODY_CLEARED
          logger.unknown(NAME) { RADIO_BODY_CLEARED }
          overwritten!
        end
      end
    end
  end
end
