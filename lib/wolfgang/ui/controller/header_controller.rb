# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class HeaderController < BaseController
        NAME = 'HeaderController'
        attr_reader :addressed_player
        alias player addressed_player

        # 'Pages' ------------------------------------------------------

        def header
          logger.debug(NAME) { '#header' }
          view = View::Header::Audio.new(addressed_player)
          renderer.render_new_header(view)
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          logger.debug('HeaderController') { "#create(#{view}) (Observers: #{addressed_player.count_observers if addressed_player})" }
          case view
          when :header
            return true if addressed_player
            @addressed_player.delete_observer(self) rescue nil
            @addressed_player = context.audio.player
            addressed_player.add_observer(self, :player_update)
            true
          else
            # logger.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          case view
          when :header
            @addressed_player.delete_observer(self)
            @addressed_player = nil
            true
          else
            # logger.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        # DATA EVENTS ------------------------------------------------------

        def player_update(action, player:)
          logger.debug('HeaderController') { "#player_update(#{action}, #{player})" }
          case action
          when :track_change
            header
          when :status
            header
          end
        end
      end
    end
  end
end
