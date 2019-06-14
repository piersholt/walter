# frozen_string_literal: true

class Wilhelm::API
  class Controls
    # Comment
    module Listener
      include Wilhelm::API::Constants::Buttons

      NAME = 'Controls Listener'

      def update(event, properties = {})
        return false unless event == :button
        logger.debug(NAME) { "#update(#{event}, #{properties})" }
        case event
        when :button
          handle_button(properties)
        end
      end

      def handle_button(button:, state:, source:)
        return false unless listeners?
        return false unless registered_control?(button)
        control = control_state[button]
        logger.debug(NAME) { "#control => #{control}" }
        control.update(state)
        # state!(source => { button => state })
        # changed
        # notify_observers(:button, button: button, state: state, source: source)
      end

      # @param strategy Strategy
      # Stateless:
      # Stateful:
      # Dynamic:
      def register_control_listener(observer, control_id, strategy = Control::Stateless, function = :control_update)
        logger.debug(NAME) { "#register_control_listener(#{control_id}, #{strategy})" }
        new_control = Control.new(control_id, strategy)
        new_control.add_observer(observer, function)
        state!(control_id => new_control)
      end

      def registered_control?(control_id)
        result = state.key?(control_id)
        logger.debug(NAME) { "#registered_control?(#{control_id}) => #{result}" }
        result
      end

      def listeners?
        true
      end
    end
  end
end
