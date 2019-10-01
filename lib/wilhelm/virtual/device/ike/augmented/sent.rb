# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Commands sent from IKE
          module Sent
            include Virtual::Constants::Events::Cluster
            include Wilhelm::Helpers::PositionalNotation

            # 0x11
            def evaluate_ignition(command)
              ignition!(command.position.value)
            end

            # 0x24
            def evaluate_anzv_var(*)
              false
            end

            # 0x2A
            def evaluate_anzv_bool(command)
              anzv_bool!(
                parse_base_256_digits(
                  command.control_a.value,
                  command.control_b.value
                )
              )
            end

            # 0x42
            def evaluate_prog(*)
              changed
              notify_observers(PROG_ON, device: ident)
            end
          end
        end
      end
    end
  end
end
