# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module View
          # Audio::UserInterface::View::Index
          class Index < SDK::UIKit::View::TitledMenu
            include SDK::UIKit::View
            NO_THINGS = [].freeze
            NO_OPTIONS = [].freeze

            def moi
              'Audio Index'
            end

            THINGS = [
              { name: 'Now Playing', action: :audio_now_playing }
            ].freeze

            OPTIONS = [
              { name: 'Play', action: :audio_play },
              { name: 'Pause', action: :audio_pause }
            ].freeze

            def initialize(addressed_player, things = THINGS, options = OPTIONS)
              @things = indexed_things(things)
              @options = indexed_options(options)
              @titles = indexed_titles(titles(addressed_player))
            end

            def menu_items
              # @things + @titles
              @things + @options + navigation_item + @titles
            end

            def titles(addressed_player)
              player_name = addressed_player.name
              [
                BaseMenuItem.new(label: 'Audio'),
                BaseMenuItem.new(label: player_name)
              ]
            end

            private

            def navigation_item
              navigation(
                index: NAVIGATION_INDEX,
                label: 'Services Menu',
                action: :main_menu_index
              )
            end

            def indexed_things(things)
              return NO_THINGS if things.length.zero?
              validate(things, COLUMN_ONE_MAX)

              things.first(COLUMN_ONE_MAX).map.with_index do |thing, index|
                indexed_thing =
                BaseMenuItem.new(label: thing[:name], action: thing[:action])
                [index, indexed_thing]
              end
            end

            def indexed_options(options)
              return NO_OPTIONS if options.length.zero?
              validate(options, COLUMN_TWO_MAX)

              options.first(COLUMN_TWO_MAX).map.with_index do |thing, index|
                indexed_thing =
                BaseMenuItem.new(label: thing[:name], action: thing[:action])
                [index + COLUMN_TWO_OFFSET, indexed_thing]
              end
            end
          end
        end
      end
    end
  end
end
