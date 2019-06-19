# frozen_string_literal: true

module Wilhelm
  module API
    class Button
      # Comment
      module Listener
        NAME = 'Button Listener'

        def update(event, properties = {})
          return false unless event == :button
          logger.debug(NAME) { "#update(#{event}, #{properties})" }
          case event
          when :button
            handle_button(properties)
          end
        end

        def handle_button(button:, state:, source:)
          state!(source => { button => state })
          changed
          notify_observers(:button, button: button, state: state, source: source)
        end
      end
    end
  end
end
