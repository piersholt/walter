# frozen_string_literal: true

class Wilhelm::API
  class Display
    # Comment
    module Listener
      include Wilhelm::API::Constants::States
      include Wilhelm::API::Constants::Buttons
      include Wilhelm::API::Constants::Commands
      
      NAME = 'Display Listener'

      def update(event, properties = {})
        # logger.debug(NAME) { "#update(#{event})" }
        # Constants::States
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

        # Constants::Commands
        case event
        when GFX_PING
          LogActually.alive.debug(NAME) { "#update(#{GFX_PING})" }
          ping
        when GFX_ANNOUNCE
          logger.debug(NAME) { "#update(#{GFX_ANNOUNCE})" }
          announce
        end

        # Constants::Buttons
        case event
        when :button
          handle_button(properties)
        end
      end
    end
  end
end
