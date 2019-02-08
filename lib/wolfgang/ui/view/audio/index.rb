# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      module Audio
        class Index < BasicMenu
          NO_SERVICES = [].freeze
          NO_OPTIONS = [].freeze

          def moi
            'Audio Index'
          end

          SERVICES = [
            { name: 'Now Playing', action: :audio_now_playing },
            { name: 'Repeat', action: :audio_repeat },
            { name: 'Shuffle', action: :audio_shuffle }
          ].freeze

          def initialize(services = SERVICES)
            @services = indexed_services(services)
            @options = indexed_options(NO_OPTIONS)
          end

          def menu_items
            # @services + @titles
            @services + @options + navigation_item
          end

          private

          def navigation_item
            navigation(index: NAVIGATION_INDEX,
                       label: 'Main Menu',
                       action: :main_menu_index)
          end


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

          def indexed_options(options)
            return NO_OPTIONS if options.length.zero?
            validate(options, COLUMN_TWO_MAX)

            options.first(COLUMN_TWO_MAX).map.with_index do |option, index|
              [index + COLUMN_TWO_OFFSET, option]
            end
          end
        end
      end
    end
  end
end
