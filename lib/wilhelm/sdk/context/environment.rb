# frozen_string_literal: false

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Context::Environment
        module Environment
          include Logging

          attr_writer :ui

          def alive?
            @state.alive?(self)
          end

          def ui
            semaphore.synchronize do
              @ui
            end
          end

          def notifications!
            @state.notifications!(self)
          end

          def ui!
            @state.ui!(self)
          end
        end
      end
    end
  end
end
