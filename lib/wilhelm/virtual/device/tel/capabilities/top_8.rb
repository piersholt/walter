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

            MOD_PROG = 'Top 8'
            LIMIT_TOP_8 = 8
            LIMIT_TOP_8_PAGE = 2

            def top_8_name(name = 'MUM')
              draw_23(gfx: TOP_8_NAME, chars: name)
            end

            def top_8_number(number = '98764321')
              draw_23(gfx: TOP_8_NUMBER, chars: number)
            end

            def top_8_clear
              draw_23(gfx: TOP_8_CLEAR, chars: STRING_BLANK)
            end

            def generate_top_8
              LOGGER.unknown(MOD_PROG) { '#generate_top_8()' }
              contacts =
                Array.new(LIMIT_TOP_8) { |i| generate_contact(i) }
              top_8_contact_list(*contacts)
            end

            def top_8_contact_list(*contacts)
              LOGGER.unknown(MOD_PROG) { "#top_8_contact_list(#{contacts})" }

              LAYOUT_INDICES[LAYOUT_TOP_8].each do |index|
                chars = contacts.shift(LIMIT_TOP_8_PAGE)&.map do |contact|
                  delimiter_contact(contact)
                end&.flatten!
                draw_21(
                  layout: LAYOUT_TOP_8,
                  m2: FUNCTION_CONTACT,
                  m3: index,
                  chars: chars
                )
              end
            end

            alias g8 generate_top_8
          end
        end
      end
    end
  end
end
