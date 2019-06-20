# frozen_string_literal: false

module Wilhelm
  module Core
    class Command
      # Command 0x38
      class ButtonParameterized < ParameterizedCommand
        def button
          action.parameters[:totally_unique_variable_name].ugly
        end

        def pretty
          action.parameters[:totally_unique_variable_name].pretty
        end

        def state
          action.parameters[:button_state].state
        end

        def state_pretty
          action.parameters[:button_state].to_s
        end

        def release?
          state == :release
        end

        def press?
          state == :press
        end

        def hold?
          state == :hold
        end

        def is?(another_button)
          button == another_button
        end

        def any?(other_buttons)
          other_buttons.one?(button)
        end
      end
    end
  end
end
