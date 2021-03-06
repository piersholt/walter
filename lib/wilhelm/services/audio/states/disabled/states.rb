# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class Disabled
        # Audio::Disabled::States
        module States
          include Logging
          include Defaults
          include Notifications

          def pending(context)
            context.change_state(Pending.new(context))
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
