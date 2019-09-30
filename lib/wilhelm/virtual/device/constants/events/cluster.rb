# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::IKE Events
        module Cluster
          # Control related events
          module Control
            IKE_CONTROL = :control
          end

          # State related events
          module State
            KL_30 = :kl_30
            KL_R  = :kl_r
            KL_15 = :kl_15
            KL_50 = :kl_50

            CLUSTER_STATES = constants.map { |i| const_get(i) }
          end

          include Control
          include State
        end
      end
    end
  end
end
