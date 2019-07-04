# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module View
          # Audio::UserInterface::View::NowPlaying
          class NowPlaying < SDK::UIKit::View::StaticMenu
            NO_PLAYER = [].freeze
            NO_OPTIONS = [].freeze

            def moi
              'Audio Now Playing'
            end

            def initialize(player)
              LOGGER.debug('NowPlaying') { "#initialize(#{player})" }
              @attributes = indexed_attributes(player)
              # @options = indexed_options(model.options)
              @options = NO_OPTIONS
            end

            def menu_items
              @attributes + @options
            end

            def input_confirm(state:)
              LOGGER.debug(self.class.name) { "#input_confirm(#{state})" }
              case state
              when :press
                nil
              when :hold
                # nil
                changed
                notify_observers(:audio_index)
              when :release
                nil
              end
            end

            private

            def indexed_attributes(player)
              [
                line1(player),
                line2(player),
                line3(player),
                line4(player),
                line5(player)
              ]
            end

            def line1(player)
              [0, Wilhelm::SDK::UserInterface::View::BaseMenuItem.new(label: player.artist)]
            end

            def line2(player)
              to_write = player.title
              to_write = to_write[0,40] if to_write.length > 40
              [1, Wilhelm::SDK::UserInterface::View::BaseMenuItem.new(label: to_write)]
            end

            def line3(player)
              [2, Wilhelm::SDK::UserInterface::View::BaseMenuItem.new(label: player.album)]
            end

            def line4(player)
              xxx = "#{player.number} of #{player.total}"
              [3, Wilhelm::SDK::UserInterface::View::BaseMenuItem.new(label: xxx)]
            end

            def line5(player)
              [4, Wilhelm::SDK::UserInterface::View::BaseMenuItem.new(label: '---------')]
            end

            MARKER = 130
            def bar
              '[' + Array.new(28) { |i| '-' }.join + MARKER.chr + Array.new(9) {|i| ' ' }.join + ']'
            end
          end
        end
      end
    end
  end
end
