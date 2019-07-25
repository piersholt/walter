# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Pending
        # Audio::Pending::States
        module States
          include Logging

          def disable(context)
            context.change_state(Disabled.new)
          end

          def off(context)
            context.change_state(Off.new(context))
          end

          def on(context)
            context.change_state(On.new(context))
          end
        end
      end
    end
  end
end
