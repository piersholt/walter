# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone Top 8 Contacts
          module Top8
            include API
            include Constants
            include Helpers::Contacts

            LIMIT_TOP_8 = 8

            def top_8_clear
              draw_23(gfx: TOP_8_CLEAR, chars: EMPTY_STRING)
            end

            def top_8_name(name = 'MUM')
              draw_23(gfx: TOP_8_NAME, chars: name)
            end

            def top_8_number(number = '98764321')
              draw_23(gfx: TOP_8_NUMBER, chars: number)
            end

            def generate_top_8
              LOGGER.unknown('Directory') { '#generate_top_8()' }
              contacts =
                LIMIT_TOP_8.times.map do |i|
                  generate_contact(i)
                end
              top_8_contact_list(*contacts)
            end

            def top_8_contact_list(*contacts)
              LOGGER.unknown('Directory') { "#top_8_contact_list(#{contacts})" }
              contacts.each do |contact|
                delimitered_contact = delimiter_contact(contact)
                LOGGER.unknown('Directory') { "#delimiter_contact(#{contact}) => #{delimitered_contact}" }
                draw_21(layout: LAYOUT_TOP_8, m3: M3_BLOCK, chars: delimitered_contact)
              end
              render_top_8
            end

            def render_top_8
              draw_21(layout: LAYOUT_TOP_8, m3: M3_NIL, chars: CHARS_EMPTY)
            end

            alias g8 generate_top_8
            alias r8 render_top_8
          end
        end
      end
    end
  end
end
