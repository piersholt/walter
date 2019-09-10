# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Services
            # Context::UserInterface::View::Services::Index
            class Index < UIKit::View::TitledMenu
              include UIKit::View
              include Constants
              NO_SERVICES = [].freeze

              def initialize(services)
                @services = indexed_services(services)
                @titles = indexed_titles(titles)
              end

              def titles
                [BaseMenuItem.new(label: 'Services')]
              end

              def menu_items
                @services + @titles + navigation_item
              end

              def reinitialize(services)
                @services = indexed_services(services)
              end

              private

              def navigation_item
                navigation(
                  index: NAVIGATION_INDEX,
                  label: 'Debug Menu',
                  action: :debug_index
                )
              end

              def indexed_services(services)
                # return NO_SERVICES if services.length.zero?
                # validate(services, COLUMN_ONE_MAX)

                services.first(COLUMN_ONE_MAX).map.with_index do |service, index|
                  indexed_service =
                  BaseMenuItem.new(
                    label: service.to_s,
                    action: service.nickname
                  )
                  [index, indexed_service]
                end
              end
            end
          end
        end
      end
    end
  end
end
