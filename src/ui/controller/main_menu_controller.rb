# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class MainMenuController < BaseController
        NAME = 'MainMenuController'

        attr_reader :services, :container

        def index
          LogActually.ui.debug(NAME) { '#index' }
          @view = View::MainMenu::Index.new(services, container)
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
            context.services.each do |service|
              service.add_observer(self, service.nickname)
            end
            @services = context.services
            context.add_observer(self, context.nickname)
            @container = context
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          case view
          when :index
            context.manager.delete_observer(self)
            context.audio.delete_observer(self)
            context.delete_observer(self)
            @services = nil
            @container = nil
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # SYSTEM EVENTS ------------------------------------------------------

        def manager(action)
          LogActually.ui.debug(NAME) { "#manager(#{action})" }
          case action
          when Manager::On
            index
          when Manager::Enabled
            index
          when Manager::Disabled
            index
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        def audio(action)
          LogActually.ui.debug(NAME) { "#audio(#{action})" }
          case action
          when Audio::On
            index
          when Audio::Enabled
            index
          when Audio::Disabled
            index
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        def wolfgang(action)
          LogActually.ui.debug(NAME) { "#wolfgang(#{action})" }
          case action
          when Service::Online
            index
          when Service::Establishing
            index
          when Service::Offline
            index
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          LogActually.ui.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
          case action
          when :manager
            destroy(:index)
            context.ui.bluetooth_controller.load(:index)
          when :audio
            destroy(:index)
            context.ui.audio_controller.load(:index)
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
