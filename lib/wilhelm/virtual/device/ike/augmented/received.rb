# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Commands received by IKE
          module Received
            include Virtual::Constants::Events::Cluster
            # 0x40
            def handle_obc_var(*)
              false
            end

            # 0x41
            def handle_obc_bool(*)
              false
            end

            # 0x42
            def handle_prog(*)
              changed
              notify_observers(PROG_OFF, device: ident)
            end
          end
        end
      end
    end
  end
end
