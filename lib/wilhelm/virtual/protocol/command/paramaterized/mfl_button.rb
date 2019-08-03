# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Command 0x38
        class MFLFunction < Button
          # @override
          def button
            return button_rt if rt?
            return button_tel if tel?
            button_rad
          end

          # @override
          def pretty
            return pretty_button_rt if rt?
            return pretty_button_tel if tel?
            pretty_button_rad
          end

          # @override
          def to_s
            str_buffer = "#{sn}\t"

            str_buffer << format_things
          end

          def format_things
            value = action.value
            value = value.kind_of?(Numeric) ? d2h(value, true) : value
            "#{value} (#{action.bit_array.to_s}) #{pretty} #{state_pretty}"
          end

          # private

          def mode?
            case button_rt
            when :mfl_rt_rad
              :rad
            when :mfl_rt_tel
              :tel
            end
          end

          def rt?
            button_rad == :mfl_null && button_tel == :mfl_null
          end

          def tel?
            button_rad == :mfl_null && button_tel != :mfl_null
          end

          def rad?
            button_tel == :mfl_null && button_rad != :mfl_null
          end

          def button_rt
            action.parameters[:button_rt].ugly
          end

          def button_rad
            action.parameters[:button_rad].ugly
          end

          def button_tel
            action.parameters[:button_tel].ugly
          end

          def pretty_button_rt
            action.parameters[:button_rt].pretty
          end

          def pretty_button_tel
            action.parameters[:button_tel].pretty
          end

          def pretty_button_rad
            action.parameters[:button_rad].pretty
          end
        end
      end
    end
  end
end
