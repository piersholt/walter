# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Code/Immobilizer Input
          module Code
            include API
            include Constants
            include Wilhelm::Helpers::Bitwise
            include Wilhelm::Helpers::PositionalNotation

            VALID_DIGITS = (0..9)
            CODE_LENGTH = 4
            CODE_KLASS = Integer

            # Code 0x0d User input of four digit code
            # @note alias code
            def input_code(*digits)
              validate_digits(*digits)
              number = parse_base_10_digits(*digits)
              code_byte_array = base_256_digits(number)

              obc_var(field: FIELD_CODE, input: code_byte_array)
            end

            alias code input_code

            private

            def validate_digits(*digits)
              validate_digit_count(*digits)
              validate_digit_type(*digits)
              validate_digit_range(*digits)
            end

            def validate_digit_count(*digits)
              return true if digits.count == CODE_LENGTH
              raise(
                ArgumentError,
                "Code length is: #{digits.size}"\
                ", but must be: #{CODE_LENGTH}"
              )
            end

            def validate_digit_type(*digits)
              return true if digits.all? { |digit| digit.is_a?(CODE_KLASS) }
              raise(
                ArgumentError,
                "Digit tyes are: #{digits.map(&:class)}"\
                ", but must all be: #{CODE_KLASS}"
              )
            end

            def validate_digit_range(*digits)
              return true if digits.all? { |digit| VALID_DIGITS.cover?(digit) }
              raise(
                ArgumentError,
                "Digits are: #{digits.join(', ')}"\
                ", but must all be: #{VALID_DIGITS}"
              )
            end
          end
        end
      end
    end
  end
end
