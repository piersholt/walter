# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        class Augmented < Device::Augmented
          # LCM::Augmented::Sent
          module Sent
            # 0x5C 58G
            def evaluate_cluster_rep(command)
              backlight!(*command.light.value)
            end
          end
        end
      end
    end
  end
end
