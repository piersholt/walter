# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class On
        # Manager::On::States
        module States
          include Logging

          def disable!(context)
            context.change_state(Disabled.new)
          end
        end
      end
    end
  end
end
