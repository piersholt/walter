# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module Model
        # Model::List
        class List
          PAGE_SIZE = 8
          INDEX = 0
          SHIFT = 1
          PROG = 'Model::List'

          attr_accessor :page_size
          attr_reader :index

          def initialize(items, page_size: PAGE_SIZE, index: INDEX)
            validate_items(items)
            validate_index(items, index)
            @items = items
            @page_size = page_size
            @index = index
          end

          def shift(i = SHIFT)
            @items.rotate!(i)
            i
          end

          def page
            @items[index, page_size]
          end

          def forward
            shift(page_size)
          end

          def backward
            shift(-page_size)
          end

          private

          def validate_items(items)
            validate_items_type(items)
            validate_items_size(items)
          end

          def validate_index(items, index)
            return true if index < items.length
            raise(IndexError, "Index is #{index}, but there's only #{items.length} items you fuckwit!")
          end

          def validate_items_type(items)
            return true if items.is_a?(Array)
            raise(TypeError, "Items is not Array! items.class => #{items.class}")
          end

          def validate_items_size(items)
            return true unless items.empty?
            raise(ArgumentError, "Items is empty! items.length => #{items.length}")
          end
        end
      end
    end
  end
end
