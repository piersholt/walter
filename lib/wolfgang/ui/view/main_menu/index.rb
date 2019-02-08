# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      module MainMenu
        # Comment
        class Index < TitledMenu
          include Logger
          NO_SERVICES = [].freeze
          NO_TITLES = [].freeze

          def initialize(services, container)
            @services = indexed_services(services)

            @titles = indexed_titles(titles(container))
            # @titles = NO_TITLES
          end

          def titles(container)
            [BaseMenuItem.new(label: 'Wolfgang'),
             BaseMenuItem.new(label: container.state_string)] +
             Array.new(10) { |i| BaseMenuItem.new(label: (i+64).chr) }
          end

          def menu_items
            @services + @titles
          end

          private

          def indexed_services(services)
            return NO_SERVICES if services.length.zero?
            validate(services, COLUMN_ONE_MAX)

            services.first(COLUMN_ONE_MAX).map.with_index do |service, index|
              # logger.debug("#{index}: #{action_service}")
              indexed_service = BaseMenuItem.new(
                                label: service.to_s,
                                action: service.nickname
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
