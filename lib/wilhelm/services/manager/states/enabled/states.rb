# frozen_string_literal: false

module Wilhelm
  module Services
    class Manager
      class Enabled
        # Manager::Enabled::States
        module States
          include Logging

          def disable!(context)
            context.change_state(Disabled.new)
          end

          def on!(context)
            context.change_state(On.new(context))
          end
        end
      end
    end
  end
end
