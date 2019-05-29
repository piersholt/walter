# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      module MainMenu
        # Comment
        class Index < TitledMenu
          include Constants
          NO_SERVICES = [].freeze

          def initialize(services, container)
            @services = indexed_services(services)
            @titles = indexed_titles(titles(container))
          end

          def titles(container)
            [BaseMenuItem.new(label: 'Wolfgang'),
             BaseMenuItem.new(label: container.state_string)]
          end

          def menu_items
            @services + @titles
          end

          private

          def indexed_services(services)
            # return NO_SERVICES if services.length.zero?
            # validate(services, COLUMN_ONE_MAX)

            services.first(COLUMN_ONE_MAX).map.with_index do |service, index|
              indexed_service =
                BaseMenuItem.new(label: service.to_s, action: service.nickname)
              [index, indexed_service]
            end
          end
        end
      end
    end
  end
end
