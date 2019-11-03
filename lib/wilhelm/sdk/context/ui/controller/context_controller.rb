# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          # ContextController
          class ContextController < UIKit::Controller::BaseController
            NAME = 'ContextController'

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
              @view&.delete_observer(self)
              @view = nil
            end

            # SYSTEM EVENTS ------------------------------------------------------

            def environment(action)
              LOGGER.debug(NAME) { "#environment(#{action})" }
              case action
              when Context::ServicesContext::Online
                update_menu(view)
              when Context::ServicesContext::Offline
                update_menu(view)
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            # USER EVENTS ------------------------------------------------------

            def update(action, selected_menu_item)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
              case action
              when :services
                ui_context.launch(:services, :index)
              when :encoding
                ui_context.launch(:encoding, :index)
              when :shutdown
                LOGGER.warn(NAME) { `/usr/bin/sudo /sbin/shutdown -h 5` }
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
