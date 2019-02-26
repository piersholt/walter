# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module Listener
      include Events
      NAME = 'Display Listener'

      def update(event, properties = {})
        case event
        when :header_cache
          header_cache(properties)
        when :header_write
          header_write(properties)
          overwritten_header!
        when :menu_cache
          # menu_cache(properties)
          false
        when :menu_write
          # menu_write(properties)
          false
        when GFX_MONITOR_ON
          logger.debug(NAME) { "#update(#{GFX_MONITOR_ON})" }
          monitor_on
        when GFX_MONITOR_OFF
          logger.debug(NAME) { "#update(#{GFX_MONITOR_OFF})" }
          monitor_off
        when GFX_OBC_REQ
          logger.debug(NAME) { "#update(#{GFX_OBC_REQ})" }
          obc_request
        when DATA_SELECT
          logger.unknown(NAME) { "#update(#{DATA_SELECT}, #{properties})" }
          data_select(properties)
        when RADIO_BODY_CLEARED
          logger.unknown(NAME) { RADIO_BODY_CLEARED }
          overwritten!
        end

        message = event
        case message
        when GFX_PING
          LogActually.alive.debug(NAME) { "#update(#{GFX_PING})" }
          ping
        when GFX_ANNOUNCE
          logger.debug(NAME) { "#update(#{GFX_ANNOUNCE})" }
          announce
        end

        button = event
        case button
        when BMBT_MENU
          logger.debug(NAME) { "#update(#{BMBT_MENU})" }
          input_menu
        when BMBT_AUX_HEAT
          logger.debug(NAME) { "#update(#{BMBT_AUX_HEAT})" }
          input_aux_heat
        when BMBT_CONFIRM
          logger.debug(NAME) { "#update(#{BMBT_CONFIRM}, #{properties || nil})" }
          input_confirm(properties)
        end
      end
    end
  end
end
