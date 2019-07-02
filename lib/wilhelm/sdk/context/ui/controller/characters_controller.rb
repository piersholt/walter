# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module Controller
        # Comment
        class CharactersController < BaseController
          NAME = 'CharactersController'

          def index
            LOGGER.debug(NAME) { '#index' }
            @view = View::Characters::Index.new(@characters_model)
            view.add_observer(self)

            render(view)
          end

          def name
            NAME
          end

          # Setup --------------------------------d----------------------

          def create(view)
            LOGGER.warn(NAME) { "#create(#{view})" }
            case view
            when :index
              # LOGGER.warn(NAME) { "@offset => #{offset}" }
              @characters_model = Model::Characters::List.new(32, 8)
              true
            else
              LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
              false
            end
          end

          def destroy
            case loaded_view
            when :index
              @characters_model = nil
              true
            else
              LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
              false
            end
          end

          # SYSTEM EVENTS ------------------------------------------------------

          # USER EVENTS ------------------------------------------------------

          def update(action, selected_menu_item)
            LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.class})" }
            case action
            when :page_next
              # LOGGER.debug(NAME) { "selected_menu_item.properties => #{selected_menu_item.properties}" }
              # destroy(:index)
              # application_context.ui.bluetooth_controller.load(:index)
              new_index = @characters_model.forward
              LOGGER.debug(NAME) { "@characters_model.backward => #{new_index}" }
              # selected_menu_item
              # @offset = selected_menu_item.properties[:offset] + 8
              # ui_context.launch(:characters, :index, selected_menu_item.properties[:offset] + 8)
              index
            when :page_previous
              # LOGGER.debug(NAME) { "selected_menu_item.properties => #{selected_menu_item.properties}" }
              # destroy(:index)
              # application_context.ui.audio_controller.load(:index)
              new_index = @characters_model.backward
              LOGGER.debug(NAME) { "@characters_model.backward => #{new_index}" }
              # selected_menu_item
              # @offset = selected_menu_item.properties[:offset] - 8
              index
            else
              LOGGER.debug(NAME) { "#update: #{action} not implemented." }
            end
          end
        end
      end
    end
  end
end
