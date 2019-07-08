# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      class Dynamic < Base
        # Device::Dynamic::Disabled
        class Disabled
          def enabled?(*)
            false
          end

          def disabled?(*)
            true
          end

          def enable!(context)
            context.change_state(Enabled.new)
          end

          def disable!(*)
            false
          end

          def virtual_receive(*)
            false
          end

          def virtual_transmit(*)
            false
          end
        end
      end
    end
  end
end
