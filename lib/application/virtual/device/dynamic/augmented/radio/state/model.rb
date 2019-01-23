# frozen_string_literal: true

class Virtual
  class AugmentedRadio < AugmentedDevice
    module State
      module Model
        include Stateful
        include Constants

        DEFAULT_STATE = {
          power: OFF,
          source: UNKNOWN,
          dependencies: EMPTY_ARRAY.dup,
          layout: UNKNOWN,
          index: UNKNOWN,
          last_pong: ZERO,
          audio_obc: OFF
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

          def layout
            state[:layout]
          end

          def on?
            power
          end

          def audio_obc?
            state[:audio_obc]
          end
        end
    end
  end
end
