# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Commands received by IKE
          module Received
            # 0x40
            def handle_obc_var(*)
              false
            end

            # 0x41
            def handle_obc_bool(*)
              false
            end
          end
        end
      end
    end
  end
end
