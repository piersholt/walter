# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Top 8 Contacts
          module Directory
            include API
            include Constants
            include Helpers::Contacts

            MOD_PROG = 'Directory'
            LIMIT_DIRECTORY = 8

            def open_directory
              draw_21(layout: LAYOUT_DIRECTORY, m2: FUNCTION_CONTACT, m3: M3_FLUSH, chars: CHARS_EMPTY)
            end

            def directory_name(name = 'MUM')
              draw_23(gfx: DIRECTORY_CONTACT_NAME, chars: name)
            end

            def directory_number(number = '98764321')
              draw_23(gfx: DIRECTORY_CONTACT_NUMBER, chars: number)
            end

            def directory_clear
              draw_23(gfx: DIRECTORY_CLEAR, chars: STRING_BLANK)
            end

            def generate_directory
              logger.unknown(MOD_PROG) { '#generate_directory()' }
              contacts =
                Array.new(LIMIT_DIRECTORY) { |i| generate_contact(i) }
              directory_contact_list(*contacts)
            end

            def directory_contact_list(*contacts)
              logger.unknown(MOD_PROG) { "#directory_contact_list(#{contacts})" }
              contacts.each.with_index do |contact, index|
                delimitered_contact = delimiter_contact(contact)
                logger.debug(MOD_PROG) { "#delimiter_contact(#{contact}) => #{delimitered_contact}" }
                m3 = index.zero? ? M3_BLOCK | M3_FLUSH : M3_BLOCK
                draw_21(layout: LAYOUT_DIRECTORY, m2: FUNCTION_CONTACT, m3: m3, chars: delimitered_contact)
              end
            end

            alias gd generate_directory
          end
        end
      end
    end
  end
end
