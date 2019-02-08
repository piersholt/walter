# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class AudioController < BaseController
        NAME = 'AudioController'
        attr_reader :addressed_player
        alias player addressed_player

        # 'Pages' ------------------------------------------------------

        def index
          logger.debug(NAME) { '#index' }
          view = View::Audio::Index.new
          view.add_observer(self)
          render(view)
        end

        def now_playing
          logger.debug(NAME) { '#now_playing' }
          view = View::Audio::NowPlaying.new(addressed_player)
          view.add_observer(self)
          render(view)
        end

        # MENU ---------------------------------------------------------------

        # def notify
        #   logger.debug(NAME) { '#notify' }
        #   2.times { bombs_away; Kernel.sleep(2.5) }
        # end
        #
        # def bombs_away
        #   logger.debug(NAME) { '#bombs_away' }
        #   view = View::NotificationHeader.new(
        #     [Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr,
        #      Random.rand(97..97+26).chr]
        #    )
        #   # view.add_observer(self)
        #   renderer.render_new_header(view)
        # end

        # Setup ------------------------------------------------------

        def create(view)
          logger.debug(NAME) { "#create(#{view})" }
          case view
          when :index
            @addressed_player = context.audio.player
            true
          when :now_playing
            @addressed_player = context.audio.player
            addressed_player.add_observer(self, :player_update)
            true
          else
            logger.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          logger.debug(NAME) { "#destroy(#{view})" }
          case view
          when :index
            # @addressed_player.delete_observer(self)
            @addressed_player = nil
            true
          when :now_playing
            @addressed_player.delete_observer(self)
            @addressed_player = nil
            true
          else
            logger.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        # selected_menu_item may just be button state for non data request
        def update(action, selected_menu_item = nil)
          logger.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" } if selected_menu_item
          logger.debug(NAME) { "#update(#{action})" } unless selected_menu_item
          case action
          when :main_menu_index
            destroy(:index)
            context.ui.root.load(:index)
          when :audio_now_playing
            destroy(:index)
            load(:now_playing)
          when :audio_index
            destroy(:now_playing)
            load(:index)
          else
            # logger.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        # DATA EVENTS ------------------------------------------------------

        def player_update(action, player:)
          logger.debug('AudioController') { "#player_update(#{action}, #{player})" }
          case action
          when :track_change
            now_playing
          when :status
            now_playing
          end
        end
      end
    end
  end
end
