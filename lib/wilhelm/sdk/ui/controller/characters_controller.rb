# frozen_string_literal: true

module Wilhelm
  class UserInterface
    module Controller
      # Comment
      class CharactersController < BaseController
        NAME = 'CharactersController'

        DEFAULT_OFFSET = 32

        def index
          LogActually.ui.debug(NAME) { '#index' }
          @view = View::Characters::Index.new(@offset)
          view.add_observer(self)

          render(view)
        end

        def name
          NAME
        end

        # Setup ------------------------------------------------------

        def create(view, offset = DEFAULT_OFFSET)
          LogActually.ui.warn(NAME) { "#create(#{view})" }
          case view
          when :index
            LogActually.ui.warn(NAME) { "@offset => #{offset}" }
            @offset = offset
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy
          case loaded_view
          when :index
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # SYSTEM EVENTS ------------------------------------------------------

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          LogActually.ui.debug(NAME) { "#update(#{action}, #{selected_menu_item.class})" }
          case action
          when :page_next
            LogActually.ui.debug(NAME) { "selected_menu_item.properties => #{selected_menu_item.properties}" }
            # destroy(:index)
            # application_context.ui.bluetooth_controller.load(:index)
            selected_menu_item
            ui_context.launch(:characters, :index, selected_menu_item.properties[:offset] + 8)
          when :page_previous
            # destroy(:index)
            # application_context.ui.audio_controller.load(:index)
            ui_context.launch(:characters, :index, 32)
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
