# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Commands sent from IKE
          module Sent
            include Virtual::Constants::Events::Cluster

            # 0x11
            def evaluate_ignition(command)
              case command.position.value
              when 0b0000_0000
                changed
                notify_observers(KL_30, device: ident)
              when 0b0000_0001
                changed
                notify_observers(KL_R, device: ident)
              when 0b0000_0011
                changed
                notify_observers(KL_15, device: ident)
              when 0b0000_0111
                changed
                notify_observers(KL_50, device: ident)
              end
            end

            # 0x24
            def evaluate_anzv_var(*)
              false
            end

            # 0x2A
            def evaluate_anzv_bool(*)
              false
            end
          end
        end
      end
    end
  end
end
