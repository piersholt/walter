# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Command 0x38
        class MFLFunction < Button
          # @override
          def button
            return mode_tel if mode_tel?
            return button_tel if tel?
            button_rad
          end

          # @override
          def pretty
            return pretty_mode_tel if mode_tel?
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

          def mode
            case mode_tel
            when :mfl_rt_rad
              :rad
            when :mfl_rt_tel
              :tel
            end
          end

          alias mode? mode

          def mode_tel?
            button_rad == :mfl_rad_null && button_tel == :mfl_tel_null
          end

          alias rt? mode_tel?

          def tel?
            button_rad == :mfl_rad_null && button_tel != :mfl_tel_null
          end

          def rad?
            button_tel == :mfl_tel_null && button_rad != :mfl_rad_null
          end

          # R/T
          def mode_tel
            action.parameters[:mode_tel].ugly
          end

          def pretty_mode_tel
            action.parameters[:mode_tel].pretty
          end

          # FORWARD/BACK
          def button_rad
            action.parameters[:button_rad].ugly
          end

          def pretty_button_rad
            action.parameters[:button_rad].pretty
          end

          # TELEPHONE
          def button_tel
            action.parameters[:button_tel].ugly
          end

          def pretty_button_tel
            action.parameters[:button_tel].pretty
          end
        end
      end
    end
  end
end
