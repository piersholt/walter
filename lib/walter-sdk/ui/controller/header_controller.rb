# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class HeaderController < BaseController
        NAME = 'HeaderController'
        attr_reader :addressed_player
        alias player addressed_player

        # def initialize(context)
        #   super(context)
        # end

        def name
          NAME
        end

        # 'Pages' ------------------------------------------------------

        def header
          LogActually.ui.unknown(NAME) { '#header' }
          view = View::Header::Status.new
          # view = View::Header::S.new(addressed_player)
          render_header(view)
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          LogActually.ui.debug('HeaderController') { "#create(#{view})" }
          case view
          when :header
            # return true if addressed_player
            # @addressed_player.delete_observer(self) rescue nil
            # @addressed_player = context.audio.player
            # addressed_player.add_observer(self, :player_update)
            true
          else
            # LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
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
            # LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        # DATA EVENTS ------------------------------------------------------

        def player_update(action, player:)
          LogActually.ui.debug('HeaderController') { "#player_update(#{action}, #{player})" }
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
