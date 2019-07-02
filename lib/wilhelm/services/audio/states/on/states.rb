# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      class On
        # Audio::On::States
        module States
          include Logging

          def disable(context)
            context.change_state(Disabled.new)
          end

          def enable(context)
            context.change_state(Enabled.new(context))
          end

          def on(context)
            context.change_state(On.new(context))
          end
        end
      end
    end
  end
end
