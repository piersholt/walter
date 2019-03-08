# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module Listener
      include Events
      NAME = 'Display Listener'

      def update(event, properties = {})
        # logger.debug(NAME) { "#update(#{event})" }
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
          logger.debug(NAME) { "#update(#{DATA_SELECT}, #{properties})" }
          data_select(properties)
        when RADIO_BODY_CLEARED
          logger.debug(NAME) { RADIO_BODY_CLEARED }
          overwritten!
        end

        case event
        when GFX_PING
          LogActually.alive.debug(NAME) { "#update(#{GFX_PING})" }
          ping
        when GFX_ANNOUNCE
          logger.debug(NAME) { "#update(#{GFX_ANNOUNCE})" }
          announce
        end

        case event
        when :button
          handle_button(properties)
        end
      end
    end
  end
end
