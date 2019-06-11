# frozen_string_literal: true

module Wilhelm
  class UserInterface
    module Model
      module Characters
        # Comment
        class List < List
          def initialize
            list_items = Array.new(256) do |i|
              { index: Kernel.format('%3.3d', i), ordinal: i }
            end
            super(list_items)
          end

          def forward
            shift(index + 10)
          end

          def backward
            shift(index - 10)
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
