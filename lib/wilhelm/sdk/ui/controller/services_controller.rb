# frozen_string_literal: true

module Wilhelm
  class UserInterface
    module Controller
      # Comment
      class ServicesController < BaseController
        NAME = 'ServicesController'

        attr_reader :services

        def index
          LogActually.ui.debug(NAME) { '#index' }
          @view = View::Services::Index.new(services)
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
            application_context.services.each do |service|
              service.add_observer(self, service.nickname)
            end
            @services = application_context.services

            # application_context.add_observer(self, application_context.nickname)
            # @container = application_context
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy
          case loaded_view
          when :index
            application_context.manager.delete_observer(self)
            application_context.audio.delete_observer(self)
            @services = nil
            # @container = nil
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
          when Walter::Manager::On
            index
          when Walter::Manager::Enabled
            index
          when Walter::Manager::Disabled
            index
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        def audio(action)
          LogActually.ui.debug(NAME) { "#audio(#{action})" }
          case action
          when Walter::Audio::On
            index
          when Walter::Audio::Enabled
            index
          when Walter::Audio::Disabled
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
            # destroy(:index)
            # application_context.ui.bluetooth_controller.load(:index)
            ui_context.launch(:bluetooth, :index)
          when :audio
            # destroy(:index)
            # application_context.ui.audio_controller.load(:index)
            ui_context.launch(:audio, :index)
          when :debug_index
            # destroy(:index)
            # destroy(:device)
            # context.ui.root.load(:index)
            ui_context.launch(:debug, :index)
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end
      end
    end
  end
end
