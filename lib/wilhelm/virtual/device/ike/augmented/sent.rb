# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Commands sent from IKE
          module Sent
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
