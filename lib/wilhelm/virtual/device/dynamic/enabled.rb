# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      class Dynamic < Base
        # Device::Dynamic::Enabled
        class Enabled
          def enabled?(*)
            true
          end

          def disabled?(*)
            false
          end

          def enable!(*)
            false
          end

          def disable!(context)
            context.change_state(Disabled.new)
          end

          def virtual_receive(context, message)
            context.handle_virtual_receive(message)
          end

          def virtual_transmit(context, message)
            context.handle_virtual_transmit(message)
          end
        end
      end
    end
  end
end
