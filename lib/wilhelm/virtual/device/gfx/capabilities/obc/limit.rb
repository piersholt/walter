# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface Limit
            module Limit
              include API
              include Constants

              NUMBER_KLASS = Integer
              VALID_NUMBERS = (0..299)

              # Speed Limit 0x09 [On, Off]
              # @param Boolean enable
              def limit(enable = true)
                obc_bool(
                  field: FIELD_LIMIT,
                  control: enable ? CONTROL_ON : CONTROL_OFF
                )
              end

              # Limit 0x09 [Set as current ppeed]
              def limit!
                obc_bool(field: FIELD_LIMIT, control: CONTROL_CURRENT_SPEED)
              end

              # Limit 0x09 Request draw OBC
              def limit?
                obc_bool(field: FIELD_LIMIT, control: CONTROL_REQUEST)
              end

              alias l limit
              alias l! limit!
              alias l? limit?

              # Speed Limit 0x09 Value (mph vs. kmph?)
              def input_limit(speed)
                LOGGER.debug('GFX::OBC::Limit') { "#input_limit(#{speed})" }
                validate_limit(speed)
                speed_byte_array = base_256_digits(speed)
                obc_var(field: FIELD_LIMIT, input: speed_byte_array)
              end

              private

              def validate_limit(speed)
                validate_speed_type(*speed)
                validate_speed_range(*speed)
              end

              def validate_speed_type(*numbers)
                return true if numbers.all? { |i| i.is_a?(NUMBER_KLASS) }
                raise(
                  ArgumentError,
                  "Number tyes are: #{numbers.map(&:class)}"\
                  ", but must all be: #{NUMBER_KLASS}"
                )
              end

              def validate_speed_range(*numbers)
                return true if numbers.all? { |i| VALID_NUMBERS.cover?(i) }
                raise(
                  ArgumentError,
                  "Numbers are: #{numbers.join(', ')}"\
                  ", but must all be: #{VALID_NUMBERS}"\
                  "P.S. #{VALID_NUMBERS.last}kmph..? Really?"
                )
              end
            end
          end
        end
      end
    end
  end
end
