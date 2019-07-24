# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Distance
            module Distance
              include API
              include Constants

              NUMBER_KLASS = Integer
              VALID_NUMBERS = (0..999)

              # Distance 0x07 Request draw OBC
              def distance?
                obc_bool(field: FIELD_DISTANCE, control: CONTROL_REQUEST)
              end

              alias d? distance?

              # Distance 0x07 Value (kms vs. miles?)
              def input_distance(distance)
                LOGGER.debug('GFX::OBC::Limit') { "#input_distance(#{distance})" }
                validate_distance(distance)
                distance_byte_array = base_256_digits(distance)
                pad_byte_array(distance_byte_array, INPUT_DISTANCE_LENGTH)

                obc_var(field: FIELD_DISTANCE, input: distance_byte_array)
              end

              private

              def validate_distance(distance)
                validate_distance_type(*distance)
                validate_distance_range(*distance)
              end

              def validate_distance_type(*numbers)
                return true if numbers.all? { |i| i.is_a?(NUMBER_KLASS) }
                raise(
                  ArgumentError,
                  "Number tyes are: #{numbers.map(&:class)}"\
                  ", but must all be: #{NUMBER_KLASS}"
                )
              end

              def validate_distance_range(*numbers)
                return true if numbers.all? { |i| VALID_NUMBERS.cover?(i) }
                raise(
                  ArgumentError,
                  "Numbers are: #{numbers.join(', ')}"\
                  ", but must all be: #{VALID_NUMBERS}"
                )
              end
            end
          end
        end
      end
    end
  end
end
