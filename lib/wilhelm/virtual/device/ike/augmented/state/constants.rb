# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # Augmented::State::Constants
            module Constants
              BITMASKS = {
                # Ignition
                kl_30: 0b0000_0000,
                kl_r:  0b0000_0001,
                kl_15: 0b0000_0010,
                kl_50: 0b0000_0100,
                # ANZV Control A
                memo:  0b0010_0000 << 8,
                timer: 0b0000_1000 << 8,
                limit: 0b0000_0010 << 8,
                # ANZV Control B
                code:            0b0100_0000,
                aux_heating:     0b0010_0000,
                aux_timer_2:     0b0001_0000,
                aux_ventilation: 0b0000_1000,
                aux_timer_1:     0b0000_0100
              }.freeze
            end
          end
        end
      end
    end
  end
end
