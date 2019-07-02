# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module View
        module Debug
          # Comment
          class Index < TitledMenu
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
              # return NO_SERVICES if options.length.zero?
              # validate(options, COLUMN_ONE_MAX)
              options = %w[Services Characters]

              options.first(COLUMN_ONE_MAX).map.with_index do |option, index|
                indexed_option =
                BaseMenuItem.new(label: option, action: option.downcase.to_sym)
                [index, indexed_option]
              end
            end
            #
            # def indexed_options(options)
            #   # return NO_SERVICES if options.length.zero?
            #   # validate(options, COLUMN_ONE_MAX)
            #
            #   options.first(COLUMN_ONE_MAX).map.with_index do |service, index|
            #     indexed_service =
            #       BaseMenuItem.new(label: service.to_s, action: service.nickname)
            #     [index, indexed_service]
            #   end
            # end
          end
        end
      end
    end
  end
end
