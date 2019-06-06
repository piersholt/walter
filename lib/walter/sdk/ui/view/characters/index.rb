# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      module Characters
        # Comment
        class Index < BasicMenu

          def initialize(offset)
            @offset = offset
            @characters = indexed_characters(offset)
          end

          def menu_items
            @characters + navigation_next + navigation_previous
          end

          private

          def navigation_next
            navigation(index: 9,
                       label: '>>',
                       action: :page_next,
                       properties: { offset: @offset + 8 })
          end

          def navigation_previous
            navigation(index: 8,
                       label: '<<',
                       action: :page_previous,
                       properties: { offset: @offset - 8 })
          end

          def indexed_characters(offset)
            (0..7).map do |index|
              byte = index + offset
              byte_label = Kernel.format('%3d', byte)
              character_item = "#{byte_label}: #{byte.chr}"
              [index, BaseMenuItem.new(label: character_item)]
            end
          end
        end
      end
    end
  end
end
