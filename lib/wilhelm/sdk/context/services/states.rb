# frozen_string_literal: false

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Context::States
        module States
          include Logging

          attr_reader :state

          def change_state(new_state)
            logger.info(WILHELM) { "State => #{new_state.class}" }
            @state = new_state
            changed
            notify_observers(state)
            @state
          end

          def online!
            @state.online!(self)
          end

          def offline!
            @state.offline!(self)
          end

          alias open online!
          alias close offline!
        end
      end
    end
  end
end
