# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module Model
        module Characters
          # Comment
          class List < List
            def initialize(index = 0, page_size = 8)
              list_items = Array.new(256) do |i|
                { index: Kernel.format('%3.3d', i), ordinal: i, hex: Kernel.format('%#2.2x', i) }
              end
              super(list_items, index: index, page_size: page_size)
            end

            def forward
              # LOGGER.unknown(self.class.name) { "#forward" }
              shift(page_size)
            end

            def backward
              # LOGGER.unknown(self.class.name) { "#backward" }
              shift(-page_size)
            end
          end
        end
      end
    end
  end
end

  # class View::List < TitledMenu
  #   PAGE_SIZE_MAX = 8
  #   ITEMS_PER_CELL = 1
  # end
