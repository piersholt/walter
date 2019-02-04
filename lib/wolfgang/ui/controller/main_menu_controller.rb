# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class MainMenuController < BaseController
        attr_reader :services

        def index
          logger.debug(self.class.name) { '#index' }
          @view = View::MainMenu::Index.new(services)
          view.add_observer(self)

          render(view)
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          case view
          when :index
            @services = context.services
            # @selected_devices.add_observer(self, :devices_update)
            true
          else
            logger.warn(self.class.name) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          case view
          when :index
            @services = nil
            # return false unless @selected_devices
            # @selected_devices.delete_observer(self)
            # @selected_devices = nil
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
          when :bluetooth_index
            destroy(:index)
            context.ui.bluetooth_controller.load(:index)
          when :audio_index
            destroy(:index)
            context.ui.audio_controller.load(:index)
          else
            logger.debug(self.class.name) { "#update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
