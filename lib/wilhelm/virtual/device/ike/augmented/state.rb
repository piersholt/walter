# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/chainable'
require_relative 'state/model'

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # Augmented IKE State
          module State
            include Model
            include Chainable

            def control_a
              bitwise_or(
                memo,
                timer,
                limit
              )
            end

            def control_b
              bitwise_or(
                code,
                aux_heating,
                aux_timer_2,
                aux_ventilation,
                aux_timer_1
              )
            end
          end
        end
      end
    end
  end
end
