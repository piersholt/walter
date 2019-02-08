# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      module Audio
        class NowPlaying < StaticMenu
          NO_PLAYER = [].freeze
          NO_OPTIONS = [].freeze

          def moi
            'Audio Now Playing'
          end

          # PLAYER_PROPERTIES = %i[line1 line2 album].freeze

          def initialize(player)
            LogActually.wolfgang.debug('NowPlaying') { "#initialize(#{player})" }
            @attributes = indexed_attributes(player)
            # @options = indexed_options(model.options)
            @options = NO_OPTIONS
          end

          def menu_items
            @attributes + @options
          end

          def input_confirm(state:)
            logger.debug(self.class.name) { "#input_confirm(#{state})" }
            changed
            notify_observers(:audio_index)
          end

          private

          # def navigation_item
          #   navigation(index: NAVIGATION_INDEX,
          #              label: 'Main Menu',
          #              action: :main_menu_index)
          # end

          # def indexed_attributes(player)
          #   return NO_VALUES if PLAYER_PROPERTIES.length.zero?
          #   validate(PLAYER_PROPERTIES, COLUMN_ONE_MAX)
          #
          #   PLAYER_PROPERTIES.first(COLUMN_ONE_MAX).map.with_index do |attribute, index|
          #     attribute_value = player.public_send(attribute)
          #     thingo = BaseMenuItem.new(label: attribute_value)
          #     [index, thingo]
          #   end
          # end

          def indexed_attributes(player)
            # return NO_VALUES if PLAYER_PROPERTIES.length.zero?
            # validate(PLAYER_PROPERTIES, COLUMN_ONE_MAX)

            [line1(player),
             line2(player),
             line3(player),
             line4(player),
             line5(player)]
          end

          def line1(player)
            [0, BaseMenuItem.new(label: player.artist)]
          end

          def line2(player)
            [1, BaseMenuItem.new(label: player.title)]
          end

          def line3(player)
            [2, BaseMenuItem.new(label: player.album)]
          end

          def line4(player)
             xxx = "#{player.number} of #{player.total}"
            [3, BaseMenuItem.new(label: xxx)]
          end

          def line5(player)
            # [4, BaseMenuItem.new(label: player.name)]
            # xxx =
              # Array.new(40) { |i| '|' }.join +
              # Array.new(40) { |i| '_' }.join
            [4, BaseMenuItem.new(label: bar)]
          end

          MARKER = 130
          def bar
            '[' + Array.new(28) { |i| '-' }.join + MARKER.chr + Array.new(9) {|i| ' ' }.join + ']'
          end

          # def indexed_options(options)
          #   return NO_OPTIONS if options.length.zero?
          #   validate(options, COLUMN_TWO_MAX)
          #
          #   options.first(COLUMN_TWO_MAX).map.with_index do |option, index|
          #     [index + COLUMN_TWO_OFFSET, option]
          #   end
          # end
        end
      end
    end
  end
end
