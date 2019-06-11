# frozen_string_literal: false

# Wilhelm::UserInterface::Controller::BaseController

class Walter
  class UserInterface
    module Controller
      # Comment
      class BluetoothController < BASE_CONTROLLER
        NAME = 'BluetoothController'

        def name
          NAME
        end

        attr_reader :selected_device, :selected_devices

        # 'Pages' ------------------------------------------------------

        def index
          LogActually.ui.debug(NAME) { '#index' }
          @view = View::Bluetooth::Index.new(@selected_devices)
          view.add_observer(self)
          render(view)
        end

        def device(selected_device = @selected_device)
          LogActually.ui.debug(NAME) { "#device(#{selected_device})" }
          @view = View::Bluetooth::Device.new(selected_device)
          view.add_observer(self)

          render(view)
        end

        # Setup ------------------------------------------------------

        def create(view, preloaded_device = nil)
          case view
          when :index
            LogActually.ui.debug(NAME) { "#create(#{view})" }
            @selected_devices = context.manager.devices
            @selected_devices.add_observer(self, :devices_update)
            true
          when :device
            LogActually.ui.debug(NAME) { "#create(#{view}, #{preloaded_device})" }
            # @selected_device = device_from_menu_item(selected_menu_item)
            @selected_device = preloaded_device
            @selected_device.add_observer(self, :device_update)
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy
          case loaded_view
          when :index
            return false unless @selected_devices
            @selected_devices.delete_observer(self)
            @selected_devices = nil
            true
          when :device
            return false unless @selected_device
            @selected_device.delete_observer(self)
            @selected_device = nil
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{loaded_view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          LogActually.ui.debug(NAME) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
          case action
          when :bluetooth_index
            # destroy(:device)
            # create(:index)
            # index
            ui_context.launch(:bluetooth, :index)
          when :bluetooth_device
            # destroy(:index)
            # create(:device, selected_menu_item: selected_menu_item)
            selected_device = device_from_menu_item(selected_menu_item)
            ui_context.launch(:bluetooth, :device, selected_device)
            # device(@selected_device)
          when :main_menu_index
            # destroy(:index)
            # destroy(:device)
            # context.ui.root.load(:index)
            ui_context.launch(:debug, :index)
          when :bluetooth_connect
            device_address = selected_menu_item.id
            context.manager.connect(device_address)
          when :bluetooth_disconnect
            device_address = selected_menu_item.id
            context.manager.disconnect(device_address)
          else
            LogActually.ui.debug(NAME) { "#update: #{action} not implemented." }
          end
        end

        # DATA EVENTS ------------------------------------------------------

        def device_update(action, device:)
          LogActually.ui.debug(NAME) { "#device_update(#{action}, #{device})" }
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
            LogActually.ui.debug(NAME) { "#device_update: #{action} not implemented." }
          end
        end

        def devices_update(action, device:)
          LogActually.ui.debug(NAME) { "#devices_update(#{action}, #{device})" }
          case action
          when :connected
            index
          when :disconnected
            index
          when :created
            index
          else
            LogActually.ui.debug(NAME) { "devices_update: #{action} not implemented." }
          end
        end

        # HELPERS ------------------------------------------------------------

        def device_from_menu_item(selected_menu_item)
          LogActually.ui.debug(NAME) { "#device_from_menu_item(#{selected_menu_item})" }
          device_address = selected_menu_item.id
          LogActually.ui.debug(NAME) { "Device Address: #{device_address}" }
          result = context.manager.devices.device(device_address)
          LogActually.ui.debug(NAME) { "Device Address: #{result.alias} (#{result.address})" }
          result
        end
      end
    end
  end
end
