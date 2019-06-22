# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          module State
            module Model
              include Wilhelm::Helpers::Stateful
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
    end
  end
end
