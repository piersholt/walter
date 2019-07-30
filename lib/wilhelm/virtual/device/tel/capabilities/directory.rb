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

            def directory_name(name = 'MUM')
              draw_23(gfx: DIRECTORY_CONTACT_NAME, chars: name)
            end

            def directory_number(number = '98764321')
              draw_23(gfx: DIRECTORY_CONTACT_NUMBER, chars: number)
            end

            def directory_clear
              draw_23(gfx: DIRECTORY_CLEAR, chars: EMPTY_STRING)
            end

            def generate_directory
              logger.unknown(MOD_PROG) { '#generate_directory()' }
              contacts =
                LIMIT_DIRECTORY.times.map do |i|
                  generate_contact(i)
                end
              directory_contact_list(*contacts)
            end

            def directory_contact_list(*contacts)
              logger.unknown(MOD_PROG) { "#directory_contact_list(#{contacts})" }
              contacts.each do |contact|
                delimitered_contact = delimiter_contact(contact)
                logger.unknown(MOD_PROG) { "#delimiter_contact(#{contact}) => #{delimitered_contact}" }
                draw_21(layout: LAYOUT_DIRECTORY, m3: M3_BLOCK, chars: delimitered_contact)
              end
              render_directory
            end

            def render_directory
              draw_21(layout: LAYOUT_DIRECTORY, m3: M3_NIL, chars: CHARS_EMPTY)
            end

            alias gd generate_directory
            alias rd render_directory
          end
        end
      end
    end
  end
end
