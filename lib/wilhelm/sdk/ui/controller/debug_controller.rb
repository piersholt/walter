# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module Controller
        # Comment
        class DebugController < BaseController
          NAME = 'DebugController'

          attr_reader :container

          def index
            LOGGER.debug(NAME) { '#index' }
            @view = View::Debug::Index.new
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
              LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
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
              LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
              false
            end
          end

          # SYSTEM EVENTS ------------------------------------------------------

          def wolfgang(action)
            LOGGER.debug(NAME) { "#wolfgang(#{action})" }
            case action
            when Environment::Online
              index
            when Environment::Offline
              index
            else
              LOGGER.debug(NAME) { "#update: #{action} not implemented." }
            end
          end

          # USER EVENTS ------------------------------------------------------

          def update(action, selected_menu_item)
            LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
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
              LOGGER.debug(NAME) { "#update: #{action} not implemented." }
            end
          end
        end
      end
    end
  end
end
