# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module Button
          # Command::Parameterized::Button::Soft
          class Soft < Button::Base
            class_variable_set(:@@configured, true)
            attr_accessor(:layout, :function)

            def format_things
              action_value =
                if action.value.kind_of?(Numeric)
                  d2h(action.value, true)
                else
                  action.value
                end
              "#{d2h(layout.value, true)}, #{d2h(function.value, true)}, #{action_value} (#{action.bit_array}) #{format('%s', pretty)}, #{format('%s', state_pretty)}"
            end
          end
        end
      end
    end
  end
end
