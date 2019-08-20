# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Command::Parameterized::Button
        # Base class for rotary switches
        class Rotary < Base
          class_variable_set(:@@configured, true)
          attr_accessor(:rotation)

          # @override Base#to_s
          def to_s
            "#{sn}\t#{format_things}"
          end

          # @override Base#format_things
          def format_things
            "#{d2h(rotation.value, true)} (#{rotation.bit_array}) :#{format('%-15s', button)} #{pretty}: #{steps}"
          end

          # Map
          def button
            rotation.parameters[:direction].ugly
          end

          def pretty
            rotation.parameters[:direction].pretty
          end

          # Integer
          def steps
            rotation.parameters[:steps].value
          end

          alias steps_pretty steps

          # backwards compatibility for button clients
          def state
            :press
          end
        end
      end
    end
  end
end
