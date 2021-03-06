# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module Button
          # Command::Parameterized::Button
          # Base class for momentary switches
          class Base < Parameterized::Base
            class_variable_set(:@@configured, true)
            attr_accessor(:action)

            def to_s
              "#{sn}\t#{format_things}"
            end

            def format_things
              value =
                if action.value.kind_of?(Numeric)
                  d2h(action.value, true)
                else
                  action.value
                end
              "#{value} (#{action.bit_array}) :#{format('%-15s', button)}\t#{format('%-15s', pretty)}\t#{format('%-15s', state_human)}"
            end

            # @override PseduoObject
            def is?(another_button)
              button == another_button
            end

            # @override PseduoObject
            def any?(other_buttons)
              other_buttons.one?(button)
            end

            # ID (Mapped)

            def button
              action.parameters[:id].ugly
            end

            def pretty
              action.parameters[:id].pretty
            end

            # STATE (Switched)

            def state
              action.parameters[:state].state
            end

            def state_human
              action.parameters[:state].pretty
            end

            def state_pretty
              action.parameters[:state].to_s
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
          end
        end
      end
    end
  end
end
