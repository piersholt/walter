# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedMFL < AugmentedDevice
    module State
      # Comment
      module Model
        include Stateful
        include Constants

        DEFAULT_STATE = {
          mode: MODE_RAD
        }.freeze

        def default_state
          DEFAULT_STATE.dup
        end

        def mode?
          state[:mode]
        end

        def mode_target
          case mode?
          when MODE_TEL
            MODE_TARGET_TEL
          when MODE_RAD
            MODE_TARGET_RAD
          end
        end
      end
    end
  end
end
