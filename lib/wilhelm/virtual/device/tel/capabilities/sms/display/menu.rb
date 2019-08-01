# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module SMS
            module Display
              # Telephone::Capabilities::SMS::Display::Menu
              module Menu
                include API
                include Constants
                include Wilhelm::Helpers::DataTools
                include Helpers::Data

                def generate_sms_index
                  generate_menu_21(layout: LAYOUT_SMS_INDEX)
                end

                def generate_sms_show
                  generate_menu_21(layout: LAYOUT_SMS_SHOW)
                end

                def generate_menu_21(
                  layout: LAYOUT_SMS_INDEX,
                  m2: ZERO,
                  indices: LAYOUT_INDICES[layout]
                )
                  indices.each do |index|
                    chars = generate_21(layout, m2, index, Random.rand(5..10))
                    draw_row_21(layout, m2, index, chars)
                  end
                  render(layout)
                  true
                end
              end
            end
          end
        end
      end
    end
  end
end
