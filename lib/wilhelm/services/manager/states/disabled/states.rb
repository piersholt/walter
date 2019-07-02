# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      class Disabled
        # Manager::Disabled::States
        module States
          def enable(context)
            context.change_state(Enabled.new(context))
          end

          def disable(context)
            context.change_state(Disabled.new)
          end

          def on(context)
            context.change_state(On.new(context))
          end
        end
      end
    end
  end
end
