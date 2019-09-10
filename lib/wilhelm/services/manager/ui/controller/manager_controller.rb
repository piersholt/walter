# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class UserInterface
        module Controller
          # Manager::UserInterface::Controller::ManagerController
          class ManagerController < SDK::UIKit::Controller::BaseController
            NAME = 'ManagerController'

            def name
              NAME
            end

            attr_reader :selected_device, :devices

            # 'Pages' ------------------------------------------------------

            def index
              LOGGER.debug(NAME) { '#index' }
              @view = View::Index.new(@devices)
              view.add_observer(self)
              render(view)
            end

            def device(selected_device = @selected_device)
              LOGGER.debug(NAME) { "#device(#{selected_device})" }
              @view = View::Device.new(selected_device)
              view.add_observer(self)

              render(view)
            end

            # Setup ------------------------------------------------------

            def create(view, preloaded_device = nil)
              case view
              when :index
                LOGGER.debug(NAME) { "#create(#{view})" }
                @devices = context.manager.devices
                @devices.add_observer(self, :devices_update)
                true
              when :device
                LOGGER.debug(NAME) { "#create(#{view}, #{preloaded_device})" }
                # @selected_device = device_from_menu_item(selected_menu_item)
                @selected_device = preloaded_device
                @selected_device.add_observer(self, :device_update)
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            end

            def destroy
              LOGGER.debug(NAME) { "#destroy(#{loaded_view})" }
              case loaded_view
              when :index
                return false unless @devices
                LOGGER.debug(NAME) { "#destroy => #{:index}" }
                @devices.delete_observer(self)
                @devices = nil
                true
              when :device
                return false unless @selected_device
                LOGGER.debug(NAME) { "#destroy => #{:device}" }
                @selected_device.delete_observer(self)
                @selected_device = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{loaded_view} view not recognised." }
                false
              end
            end

            # USER EVENTS ------------------------------------------------------

            def update(action, selected_menu_item)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
              case action
              when :bluetooth_index
                ui_context.launch(:manager, :index)
              when :bluetooth_device
                selected_device = device_from_menu_item(selected_menu_item)
                ui_context.launch(:manager, :device, selected_device)
              when :main_menu_index
                ui_context.launch(:services, :index)
              when :bluetooth_connect
                context.manager.connect_device(@selected_device)
              when :bluetooth_disconnect
                context.manager.disconnect_device(@selected_device)
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            # DATA EVENTS ------------------------------------------------------

            def device_update(action, device:)
              LOGGER.debug(NAME) { "#device_update(#{action}, #{device})" }
              case action
              when :connecting
                device(device)
              when :disconnecting
                device(device)
              when :connected
                device(device)
              when :disconnected
                device(device)
              else
                LOGGER.warn(NAME) { "#device_update: #{action} not implemented." }
              end
            end

            def devices_update(action, device:)
              LOGGER.debug(NAME) { "#devices_update(#{action}, #{device})" }
              case action
              when :connected
                index
              when :disconnected
                index
              when :devices_created
                index
              when :devices_updated
                index
              else
                LOGGER.warn(NAME) { "devices_update: #{action} not implemented." }
              end
            end

            # HELPERS ------------------------------------------------------------

            def device_from_menu_item(selected_menu_item)
              LOGGER.debug(NAME) { "#device_from_menu_item(#{selected_menu_item})" }
              id = selected_menu_item.id
              LOGGER.debug(NAME) { "Device Address: #{id}" }
              result = context.manager.devices.find_by_id(id)
              LOGGER.debug(NAME) { "Device Address: #{result.alias} (#{result.address})" }
              result
            end
          end
        end
      end
    end
  end
end
