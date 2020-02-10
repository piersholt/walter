# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          # ServicesController
          class ServicesController < UIKit::Controller::BaseController
            NAME = 'ServicesController'

            attr_reader :services

            def index
              LOGGER.debug(NAME) { '#index' }
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
                  service.add_observer(self, "#{service.nickname}_update".to_sym)
                end
                @services = application_context.services
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            end

            def destroy
              case loaded_view
              when :index
                application_context.services.each do |service|
                  service.delete_observer(self)
                end
                @services = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
                false
              end
              @view&.delete_observer(self)
              @view = nil
            end

            # SYSTEM EVENTS ------------------------------------------------------

            def manager_update(new_state)
              LOGGER.debug(NAME) { "#manager_update(#{new_state})" }
              case new_state
              when Wilhelm::Services::Manager::Disabled
                @view&.reinitialize(services)
                update_menu(view)
              when Wilhelm::Services::Manager::Pending
                @view&.reinitialize(services)
                update_menu(view)
              when Wilhelm::Services::Manager::On
                @view&.reinitialize(services)
                update_menu(view)
              else
                LOGGER.debug(NAME) { "#manager_update: #{new_state} not implemented." }
              end
            end

            def audio_update(new_state)
              LOGGER.debug(NAME) { "#audio_update(#{new_state})" }
              case new_state
              when Wilhelm::Services::Audio::Disabled
                @view&.reinitialize(services)
                update_menu(view)
              when Wilhelm::Services::Audio::Pending
                @view&.reinitialize(services)
                update_menu(view)
              when Wilhelm::Services::Audio::Off
                @view&.reinitialize(services)
                update_menu(view)
              when Wilhelm::Services::Audio::On
                @view&.reinitialize(services)
                update_menu(view)
              else
                LOGGER.debug(NAME) { "#audio_update: #{new_state} not implemented." }
              end
            end

            # USER EVENTS ------------------------------------------------------

            def update(action, selected_menu_item)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
              case action
              when :manager
                ui_context.launch(:manager, :index)
              when :audio
                ui_context.launch(:audio, :index)
              when :context_index
                ui_context.launch(:context, :index)
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end
          end
        end
      end
    end
  end
end
