# frozen_string_literal: true

module Wilhelm
  module API
    class Controls
      # API::Controls::Listener
      module Listener
        # it's technicall not BMBT_BUTTON, as MFL sends it too
        include Constants::Controls::BMBT
        include Constants::Controls::MFL

        NAME = 'Controls Listener'

        def update(event, properties = {})
          # TODO :control => BMBT_BUTTON/MFL_BUTTON
          return false unless event == :control
          logger.debug(NAME) { "#update(#{event}, #{properties})" }
          handle_control(properties)
        end

        def handle_control(control:, state:, source:)
          return false unless listeners?
          return false unless registered_control?(control)
          control = control_state[control]
          logger.debug(NAME) { "#control => #{control}" }
          control.update(state)
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

        # @todo I can't remember what I had intended here?
        def listeners?
          true
        end
      end
    end
  end
end
