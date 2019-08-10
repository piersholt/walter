# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # API::Display::Listener
      module Listener
        include Constants::Events

        NAME = 'Display Listener'

        def update(event, properties = {})
          # logger.debug(NAME) { "#update(#{event}, #{properties})" }
          return update_cache(event, properties) if cache?(event)
          return update_state(event, properties) if state?(event)
          return update_control(event, properties) if control?(event)
        end

        private

        # CACHE
        def update_cache(event, properties = {})
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
        end

        # STATE
        def update_state(event, properties = {})
          case event
          when GFX_MONITOR_ON
            logger.debug(NAME) { "#update(#{GFX_MONITOR_ON})" }
            monitor_on
          when GFX_MONITOR_OFF
            logger.debug(NAME) { "#update(#{GFX_MONITOR_OFF})" }
            monitor_off
          when GFX_PING
            logger.debug(NAME) { "#update(#{GFX_PING})" }
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
        end

        # CONTROL
        def update_control(event, properties = {})
          case event
          when GFX_DATA_SELECT
            logger.debug(NAME) { "#update(#{GFX_DATA_SELECT}, #{properties})" }
            data_select(properties)
          when BMBT_BUTTON
            logger.debug(NAME) { "#update(#{BMBT_BUTTON}, #{properties})" }
            handle_control(properties)
          when MFL_BUTTON
            logger.debug(NAME) { "#update(#{MFL_BUTTON}, #{properties})" }
            handle_control(properties)
          end
        end
      end
    end
  end
end
