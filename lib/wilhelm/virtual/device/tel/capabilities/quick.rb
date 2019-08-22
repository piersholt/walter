# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Quick
          module Quick
            include API
            include Constants

            MOD_PROG = 'Quick'

            QUICK_PREFIX    = 'TEL'
            QUICK_DELIMITER = '-'
            QUICK_NAME      = 'QuickContact'
            QUICK_NUMBER    = '555-1234'
            QUICK_ERROR     = 'INSERT CARD!'

            def quick_name(index = 0, text = QUICK_NAME)
              formatted_text = format_quick_contact(index, text)
              draw_23(to: :ike, gfx: 0x42, ike: 0x20, chars: formatted_text)
            end

            def quick_number(index = 0, text = QUICK_NUMBER)
              formatted_text = format_quick_contact(index, text)
              draw_23(to: :ike, gfx: 0x43, ike: 0x10, chars: formatted_text)
            end

            def quick_call_start(text = QUICK_NUMBER)
              formatted_text = format_quick_dial(text)
              draw_23(to: :ike, gfx: 0x43, ike: 0x20, chars: formatted_text)
            end

            def quick_call_end
              draw_23(to: :ike, gfx: 0x40, ike: 0x20, chars: '')
            end

            def quick_exit
              draw_23(to: :ike, gfx: 0x41, ike: 0x20, chars: '')
            end

            def quick_error(text = QUICK_ERROR)
              draw_23(to: :ike, gfx: 0x40, ike: 0x20, chars: text)
            end

            private

            # @return String "TEL9-NAME"
            def format_quick_contact(index = 0, text)
              "#{QUICK_PREFIX}#{index}#{QUICK_DELIMITER}#{text}"
            end

            # @return String "TEL 999"
            def format_quick_dial(text)
              "#{QUICK_PREFIX}#{text}"
            end
          end
        end
      end
    end
  end
end
