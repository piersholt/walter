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
