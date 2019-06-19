# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    # Comment
    class AugmentedMFL < AugmentedDevice
      module State
        # Comment
        module Model
          include Wilhelm::Helpers::Stateful
          include Constants

          DEFAULT_STATE = {
            mode: DEFAULT_MODE
          }.freeze

          def default_state
            DEFAULT_STATE.dup
          end

          # Mode ---------------------------------------------

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
end
