# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module Button
          # Command::Parameterized::Button::BMBT
          class BMBT < Button::Base
            # @override Base#to_s
            def to_s
              str_buffer = "#{sn}\t"

              str_buffer << format_things
            end

            # @override Base#format_things
            def format_things
              value = action.value
              value = value.kind_of?(Numeric) ? d2h(value, true) : value
              "#{value} (#{action.bit_array}) #{pretty} #{state_pretty}"
            end
          end
        end
      end
    end
  end
end
