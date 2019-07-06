# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Debug
            # Context::UserInterface::View::Debug::Index
            class Index < UIKit::View::TitledMenu
              include UIKit::View
              include Constants

              NO_SERVICES = [].freeze

              def initialize
                @options = indexed_options
                @titles = indexed_titles(titles)
              end

              def titles
                [BaseMenuItem.new(label: 'Debug')]
              end

              def menu_items
                @options + @titles
              end

              private

              def indexed_options
                options = %w[Services Encoding]
                options.first(COLUMN_ONE_MAX).map.with_index do |option, index|
                  indexed_option =
                  BaseMenuItem.new(label: option, action: option.downcase.to_sym)
                  [index, indexed_option]
                end
              end
            end
          end
        end
      end
    end
  end
end
