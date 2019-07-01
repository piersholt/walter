# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Command 0x31
      class DataTelephone < ParameterizedCommand
        # parameters
        # source
        # function
        # action: button_id, button_state

        def index
          button_id&.value
        end

        def state
          button_state&.state
        end

        def press?
          state == :press
        end

        def hold?
          state == :hold
        end

        def release?
          state == :release
        end

        private

        def button_id
          action.parameters[:button_id]
        end

        def button_state
          action.parameters[:button_state]
        end
      end
    end
  end
end
