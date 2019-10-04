# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # PIN Mock
            module PIN
              include Constants

              MOD_PROG = 'PIN'.freeze

              def service_pin_open
                logger.debug(PROC) { '#service_pin_open' }
                pin!
                open_pin
              end

              def pin_service_input(index)
                pin!
                return pin_service_delete if index == ACTION_PIN_DELETE
                return pin_service_flush && dial_open if index == ACTION_PIN_OK
                indexed_string = twig(LAYOUT_PIN, FUNCTION_DIGIT, index)
                pin_service_number(indexed_string)
              end

              def pin_service_number(digit = '0')
                add_pin_digit(digit)
                pin_number(pin_buffer)
              end

              def pin_service_delete
                remove_pin_digit
                pin_number(pin_buffer)
              end

              def pin_service_flush
                clear_pin_buffer
                pin_clear
              end

              private

              def add_pin_digit(digit)
                pin_buffer << digit
              end

              def remove_pin_digit
                pin_buffer.chop!
              end

              def clear_pin_buffer
                pin_buffer.clear
              end

              def pin_buffer
                @pin_buffer ||= STRING_BLANK.dup
              end
            end
          end
        end
      end
    end
  end
end
