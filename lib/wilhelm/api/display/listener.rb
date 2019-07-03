# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      module Listener
        include Constants::Events::Display

        NAME = 'Display Listener'

        def update(event, properties = {})
          # logger.debug(NAME) { "#update(#{event})" }

          # CACHE
          case event
          when HEADER_CACHE
            header_cache(properties)
          when HEADER_WRITE
            header_write(properties)
            overwritten_header!
          when MENU_CACHE
            # menu_cache(properties)
            false
          when MENU_WRITE
            # menu_write(properties)
            false
          end

          # STATE
          case event
          when GFX_MONITOR_ON
            logger.debug(NAME) { "#update(#{GFX_MONITOR_ON})" }
            monitor_on
          when GFX_MONITOR_OFF
            logger.debug(NAME) { "#update(#{GFX_MONITOR_OFF})" }
            monitor_off
          when GFX_PING
            LOGGER.debug(NAME) { "#update(#{GFX_PING})" }
            ping
          when GFX_ANNOUNCE
            logger.debug(NAME) { "#update(#{GFX_ANNOUNCE})" }
            announce
          when GFX_OBC_BOOL
            logger.info(NAME) { "#update(#{GFX_OBC_BOOL}, #{properties})" }
            obc_request
          when RADIO_BODY_CLEARED
            logger.debug(NAME) { "#update(#{RADIO_BODY_CLEARED})" }
            overwritten!
          end

          # INPUT
          case event
          when DATA_SELECT
            logger.debug(NAME) { "#update(#{DATA_SELECT}, #{properties})" }
            data_select(properties)
          when BMBT_BUTTON
            handle_button(properties)
          end
        end
      end
    end
  end
end
