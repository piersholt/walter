# frozen_string_literal: true

module Wilhelm
  module API
    class Button
      # Comment
      module Listener
        NAME = 'Button Listener'

        def update(event, properties = {})
          return false unless event == :control
          logger.debug(NAME) { "#update(#{event}, #{properties})" }
          case event
          when :control
            handle_control(properties)
          end
        end

        def handle_control(control:, state:, source:)
          state!(source => { control => state })
          changed
          notify_observers(:control, control: control, state: state, source: source)
        end
      end
    end
  end
end
