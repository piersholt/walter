# frozen_string_literal: false

module Wilhelm
  module SDK
    class UserInterface
      module View
        module Characters
          # Comment
          class Index < BasicMenu
            def initialize(characters_model)
              @characters = parse_model(characters_model)
            end

            def menu_items
              @characters + navigation_previous + navigation_next
            end

            private

            def navigation_previous
              navigation(index: 8, label: 171.chr, action: :page_previous)
            end

            def navigation_next
              navigation(index: 9,
                label: 187.chr,
                action: :page_next)
              end

              def parse_model(characters_model)
                characters_model.page.map.with_index do |character, index|
                  label_buffer = character[:index] + ': ' + '[' + character[:ordinal].chr + ']'
                  [index, BaseMenuItem.new(label: label_buffer)]
                end
              end
            end
          end
        end
      end
    end
end
