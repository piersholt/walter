# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # IKE State Model
            module Model
              include Wilhelm::Helpers::Stateful
              include Constants

              DEFAULT_STATE = {
                ignition: 0b0000_0000,
                anzv_bool: 0b0000_0000_0000_0000
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end
            end
          end
        end
      end
    end
  end
end
