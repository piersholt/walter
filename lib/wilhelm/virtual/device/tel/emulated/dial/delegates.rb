# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Dial
            # Device::Telephone::Emulated::Dial::Handler
            module Delegates
              include Constants

              MOD_PROG = 'Dial'.freeze
              LEADING_CHAR = '_'.freeze

              def dial_open
                logger.debug(MOD_PROG) { '#dial_open()' }
                dial!
                open_dial
                # dial_clear
              end

              def dial_select(index)
                return dial_service_delete if index == ACTION_DIAL_DELETE
                indexed_string = twig(LAYOUT_DIAL, FUNCTION_DIGIT, index)
                dial_service_number(indexed_string)
              end

              protected

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
                # dial_clear
              end

              private

              def dial_buffer
                @dial_buffer ||= STRING_BLANK.dup
              end

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
            end
          end
        end
      end
    end
  end
end
