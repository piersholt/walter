# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      module MainMenu
        class Index < TitledMenu
          NO_SERVICES = [].freeze
          NO_TITLES = [].freeze

          def initialize(services)
            @services = indexed_services(services)
            main_menu_title = BaseMenuItem.new(label: 'Main Menu')
            @titles = indexed_titles([main_menu_title])
            # @titles = NO_TITLES
          end

          def menu_items
            @services + @titles
          end

          private

          def indexed_services(services)
            return NO_SERVICES if services.length.zero?
            validate(services, COLUMN_ONE_MAX)

            services.first(COLUMN_ONE_MAX).map.with_index do |service, index|
              indexed_service = BaseMenuItem.new(
                                label: service[:name],
                                action: service[:action]
                              )
              [index, indexed_service]
            end
          end

          def indexed_titles(titles)
            # return NO_TITLES if titles.length.zero?
            # validate(titles, COLUMN_TWO_MAX)

            titles.first(TITLE_MAX).map.with_index do |option, index|
              [index + TITLE_OFFSET, option]
            end
          end
        end
      end
    end
  end
end
