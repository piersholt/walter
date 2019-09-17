# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Dial Telephone Number
            module Dial
              include Constants

              MOD_PROG = 'Mock::Dial'.freeze
              LEADING_CHAR = '_'.freeze

              def dial_service_open
                LOGGER.unknown(MOD_PROG) { '#dial_service_open()' }
                dial!
                open_dial
                dial_clear
              end

              def dial_service_input(index)
                return dial_service_delete if index == ACTION_DIAL_DELETE
                indexed_string = twig(LAYOUT_DIAL, FUNCTION_DIGIT, index)
                dial_service_number(indexed_string)
              end

              def dial_service_number(digit = '0')
                add_dial_digit(digit)
                dial_number(dial_buffer + LEADING_CHAR)
              end

              def dial_service_delete
                remove_dial_digit
                dial_number(dial_buffer + LEADING_CHAR)
              end

              def dial_service_flush
                clear_dial_buffer
                dial_clear
              end

              private

              def add_dial_digit(digit)
                dial_buffer << digit
              end

              def remove_dial_digit
                dial_buffer.chop!
              end

              def clear_dial_buffer
                dial_buffer.clear
              end

              def dial_buffer?
                !dial_buffer.empty?
              end

              def dial_buffer
                @dial_buffer ||= STRING_BLANK.dup
              end
            end
          end
        end
      end
    end
  end
end
