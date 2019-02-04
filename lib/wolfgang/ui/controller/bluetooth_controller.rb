# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class BluetoothController < BaseController
        attr_reader :selected_device, :selected_devices

        # 'Pages' ------------------------------------------------------

        def index
          logger.debug(self.class.name) { '#index' }
          @view = View::Bluetooth::Index.new(@selected_devices)
          view.add_observer(self)
          render(view)
        end

        def device(selected_device)
          logger.debug(self.class.name) { "#device(#{selected_device})" }
          @view = View::Bluetooth::Device.new(selected_device)
          view.add_observer(self)

          render(view)
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          case view
          when :index
            @selected_devices = context.manager.devices
            @selected_devices.add_observer(self, :devices_update)
            true
          when :device
            @selected_device = device_from_menu_item(selected_menu_item)
            @selected_device.add_observer(self, :device_update)
            true
          else
            logger.warn(self.class.name) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          case view
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
            logger.warn(self.class.name) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------

        def update(action, selected_menu_item)
          logger.debug(self.class.name) { "#update(#{action}, #{selected_menu_item.id || selected_menu_item})" }
          case action
          when :bluetooth_index
            destroy(:device)
            create(:index)
            index
          when :bluetooth_device
            destroy(:index)
            create(:device, selected_menu_item: selected_menu_item)
            device(@selected_device)
          when :main_menu_index
            destroy(:index)
            destroy(:device)
            context.ui.root.load(:index)
          when :bluetooth_connect
            device_address = selected_menu_item.id
            context.manager.connect(device_address)
          when :bluetooth_disconnect
            device_address = selected_menu_item.id
            context.manager.disconnect(device_address)
          else
            logger.debug(self.class.name) { "#update: #{action} not implemented." }
          end
        end

        # DATA EVENTS ------------------------------------------------------

        def device_update(action, device:)
          logger.debug(self.class.name) { "#device_update(#{action}, #{device})" }
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
            logger.debug(self.class.name) { "#device_update: #{action} not implemented." }
          end
        end

        def devices_update(action, device:)
          logger.debug(self.class.name) { "#devices_update(#{action}, #{device})" }
          case action
          when :connected
            index
          when :disconnected
            index
          when :created
            index
          else
            logger.debug(self.class.name) { "devices_update: #{action} not implemented." }
          end
        end

        # HELPERS ------------------------------------------------------------

        def device_from_menu_item(selected_menu_item)
          logger.debug(self.class.name) { "#device_from_menu_item(#{selected_menu_item})" }
          device_address = selected_menu_item.id
          logger.debug(self.class.name) { "Device Address: #{device_address}" }
          result = context.manager.devices.device(device_address)
          logger.debug(self.class.name) { "Device Address: #{result.alias} (#{result.address})" }
          result
        end
      end
    end
  end
end
