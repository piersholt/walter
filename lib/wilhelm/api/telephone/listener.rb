# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::Listener
      module Listener
        include Constants::Events

        PROG = 'Telephone::Listener'

        def update(event, **properties)
          return handle_action(event, properties) if action?(event)
        end

        def handle_action(event, properties)
          logger.unknown(PROG) { "#handle_action(#{event}, #{properties})" }
          changed
          notify_observers(event, properties)
        end

        def register_telephone_listener(observer)
          logger.unknown(PROG) { "#register_telephone_listener()" }
          add_observer(observer, :telephone_update)
        end
      end
    end
  end
end
