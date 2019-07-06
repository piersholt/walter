# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Encoding
            # Context::UserInterface::Model::Characters::List
            class CodeList < UIKit::Model::List
              CHARACTER_SET_SIZE = 256
              INITIAL_INDEX = 0
              PAGE_SIZE = 8

              def initialize(index = INITIAL_INDEX, page_size = PAGE_SIZE)
                list_items = Array.new(CHARACTER_SET_SIZE) do |i|
                  {
                    ordinal: i,
                    decimal: Kernel.format('%3.3d', i),
                    hex: Kernel.format('%#2.2x', i)
                  }
                end
                super(list_items, index: index, page_size: page_size)
              end
            end
          end
        end
      end
    end
  end
end
