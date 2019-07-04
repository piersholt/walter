# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Characters
            # Context::UserInterface::Model::Characters::List
            class List < UIKit::Model::List
              def initialize(index = 0, page_size = 8)
                list_items = Array.new(256) do |i|
                  { index: Kernel.format('%3.3d', i), ordinal: i, hex: Kernel.format('%#2.2x', i) }
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
