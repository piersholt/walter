# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class AudioController < BaseController
        attr_reader :addressed_player
        alias player addressed_player

        # 'Pages' ------------------------------------------------------

        def index
          logger.debug(self.class.name) { '#index' }
          view = View::Audio::Index.new()
          view.add_observer(self)
          render(view)
        end

        def header
          logger.debug(self.class.name) { '#header' }
          view = View::Audio::NowPlaying.new(addressed_player)
          renderer.render_new_header(view)
        end

        # MENU ---------------------------------------------------------------

        # def notify
        #   logger.debug(self.class.name) { '#notify' }
        #   2.times { bombs_away; Kernel.sleep(2.5) }
        # end
        #
        # def bombs_away
        #   logger.debug(self.class.name) { '#bombs_away' }
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

        def create(view, selected_menu_item: nil)
          case view
          when :header
            @addressed_player = context.audio.player
            addressed_player.add_observer(self, :player_update)
            true
          when :index
            @addressed_player = context.audio.player
            true
          else
            false
          end
        end

        def destroy(view)
          case view
          when :index
            @addressed_player.delete_observer(self)
            @addressed_player = nil
            true
          else
            logger.warn(self.class.name) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          logger.debug(self.class.name) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
          case action
          when :main_menu_index
            destroy(:index)
            context.ui.root.load(:index)
          else
            logger.debug(self.class.name) { "#update: #{action} not implemented." }
          end
        end

        # DATA EVENTS ------------------------------------------------------

        def player_update(action, player:)
          logger.debug('AudioController') { "#player_update(#{action}, #{player})" }
          case action
          when :track_start
            return false if addressed_player.position <= 1500 && addressed_player.position != player.position
            header
          when :status
            header
          # when :repeat
            # header
          # when :shuffle
            # header
          # when :track_change
          # when :track_end
          # when :position
          else
            logger.debug(self.class.name) { "#player_update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
