# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module View
          # Audio::UserInterface::View::NowPlaying
          class NowPlaying < SDK::UIKit::View::StaticMenu
            include SDK::UIKit::View
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

            def reinitialize(player)
              @attributes = indexed_attributes(player)
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
              [0, BaseMenuItem.new(label: player.title)]
            end

            def line2(player)
              [1, BaseMenuItem.new(label: player.artist)]
            end

            def line3(player)
              [2, BaseMenuItem.new(label: player.album)]
            end

            def line4(player)
              [3, BaseMenuItem.new(label: track_numbers(player))]
            end

            def line5(player)
              [4, View::ElapsedTime.new(player.timer.elapsed_time, player.duration)]
            end

            def track_numbers(player)
              "#{player.track_number} of #{player.number_of_tracks}"
            end
          end
        end
      end
    end
  end
end
