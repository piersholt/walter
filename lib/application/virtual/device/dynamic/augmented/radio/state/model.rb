# frozen_string_literal: true

class Virtual
  class AugmentedRadio < AugmentedDevice
    module State
      module Model
        include Stateful
        include Constants

        DEFAULT_STATE = {
          power: :off,
          source: UNKNOWN,
          dependencies: EMPTY_ARRAY.dup,
          header: UNKNOWN,
          index: UNKNOWN,
          last_pong: ZERO
        }.freeze

          def default_state
            DEFAULT_STATE.dup
          end

          # Power

          def power
            state[:power]
          end

          def source
            state[:source]
          end

          def dependencies
            state[:dependencies]
          end

          def on?
            power
          end
        end

    end
  end
end
