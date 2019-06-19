# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module View
        module Nodes
          # Comment
          class Index < TitledMenu
            include Constants
            NO_NODES = [].freeze

            def initialize(nodes)
              @nodes = indexed_nodes(nodes)
              @titles = indexed_titles(titles)
            end

            def titles
              [BaseMenuItem.new(label: 'Nodes')]
            end

            def menu_items
              @nodes + @titles + navigation_item
            end

            private

            def navigation_item
              navigation(index: NAVIGATION_INDEX,
                label: 'Debug Menu',
                action: :debug_index)
              end

              def indexed_nodes(nodes)
                # return NO_NODES if nodes.length.zero?
                # validate(nodes, COLUMN_ONE_MAX)

                nodes.first(COLUMN_ONE_MAX).map.with_index do |node, index|
                  indexed_node =
                  BaseMenuItem.new(label: node.to_s, action: node.nickname)
                  [index, indexed_node]
                end
              end
            end
          end
        end
      end
    end
end
