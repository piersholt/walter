module Wolfgang
  class UserInterface
    attr_accessor :context, :header, :root
    # attr_reader :root

    def to_s
      '<UserInterface>'
    end

    def inspect
      '<UserInterface>'
    end

    def audio_controller
      @audio_controller ||= Controller::AudioController.new(context)
    end

    def bluetooth_controller
      @bluetooth_controller ||= Controller::BluetoothController.new(context)
    end

    def initialize(context, root = Controller::MainMenuController, header = Controller::AudioController)
      context.manager.device_list
      context.audio.send_me_everyone
      Kernel.sleep(1.5)
      @context = context
      @header = create_header(header)
      @root = create_menu(root)
    end

    def create_header(header_controller)
      x = header_controller.new(context)
      x.load_header
      x
    end

    def create_menu(root_controller)
      y = root_controller.new(context)
      # @root.renderer = Virtual::Display.instance
      y.load
      y
    end
  end
end

# def input_left(value)
#   # rotate menu_items by -value
#   # hightlight menu_items[0]
#   LogActually.wolfgang.debug(self.class) { "#input_left(#{value})" }
#   LogActually.wolfgang.debug(self.class) { menu_items }
#   menu_items.rotate!(value)
#   LogActually.wolfgang.debug(self.class) { "Rotated: #{menu_items}" }
#   hover_item = menu_items[0]
#   LogActually.wolfgang.debug(self.class) { "Selected Item => #{hover_item}" }
#   highlight_item(hover_item)
# end
#
# def input_right(value)
#   # rotate menu_items by value
#   # hightlight_item(menu_items[0])
#   LogActually.wolfgang.debug(self.class) { "#input_right(#{value})" }
#   LogActually.wolfgang.debug(self.class) { menu_items }
#   menu_items.rotate!(value * -1)
#   LogActually.wolfgang.debug(self.class) { "Rotated: #{menu_items}" }
#   hover_item = menu_items[0]
#   LogActually.wolfgang.debug(self.class) { "Selected Item => #{hover_item}" }
#   highlight_item(hover_item)
# end

# properties = []
# properties <<  View::BaseMenuItem.new(id: :name, label: 'PH7', action: :bluetooth_add)
# properties <<  View::BaseMenuItem.new(id: :alias, label: 'iPhone 7', action: :bluetooth_add)
# properties <<  View::BaseMenuItem.new(id: :address, label: '70:70:0D:11:CF:29', action: :bluetooth_remove)
# properties <<  View::BaseMenuItem.new(id: :rssi, label: 'RSSI -100dB', action: :bluetooth_remove)
# properties <<  View::BaseMenuItem.new(id: :trusted, label: (Kernel.format("%-13s", 'Trusted') << 42.chr), action: :bluetooth_remove)
# properties <<  View::BaseMenuItem.new(id: :adapter, label: 'CB1107', action: :bluetooth_remove)
# PROPERTIES = properties
