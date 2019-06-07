# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class DebugController < BaseController
        NAME = 'DebugController'

        attr_reader :container

        def index
          LogActually.ui.debug(NAME) { '#index' }
          @view = View::MainMenu::Index.new
          view.add_observer(self)

          render(view)
        end

        def name
          NAME
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          case view
          when :index
            application_context.add_observer(self, application_context.nickname)
            @container = application_context
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy
          case loaded_view
          when :index
            application_context.delete_observer(self)
            @container = nil
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # SYSTEM EVENTS ------------------------------------------------------

        def wolfgang(action)
          LogActually.ui.debug(NAME) { "#wolfgang(#{action})" }
          case action
          when ApplicationContext::Online
            index
          when ApplicationContext::Offline
            index
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          LogActually.ui.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
          case action
          when :nodes
            # destroy(:index)
            # application_context.ui.bluetooth_controller.load(:index)
            ui_context.launch(:nodes, :index)
          when :services
            # destroy(:index)
            # application_context.ui.audio_controller.load(:index)
            ui_context.launch(:services, :index)
          when :characters
            # destroy(:index)
            # application_context.ui.audio_controller.load(:index)
            ui_context.launch(:characters, :index)
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
