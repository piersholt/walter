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
          return update_control(event, properties) if control?(event)
          return update_state(event, properties) if state?(event)
          return update_cache(event, properties) if cache?(event)
        end

        private

        # CACHE
        def update_cache(event, properties = {})
          case event
          when HEADER_CACHE
            header_cache(properties)
          when HEADER_WRITE
            header_write(properties)
          when MENU_CACHE
            menu_cache(properties)
          when MENU_WRITE
            menu_write(properties)
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
          end
        end

        # CONTROL
        def update_control(event, properties = {})
          case event
          when GFX_CONTROL
            logger.debug(NAME) { "#update(#{GFX_CONTROL}, #{properties})" }
            data_select(properties)
          when BMBT_CONTROL
            logger.debug(NAME) { "#update(#{BMBT_CONTROL}, #{properties})" }
            handle_control(properties)
          when MFL_CONTROL
            logger.debug(NAME) { "#update(#{MFL_CONTROL}, #{properties})" }
            handle_control(properties)
          end
        end
      end
    end
  end
end
