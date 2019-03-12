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

    def initialize(context,
                   root = Controller::MainMenuController,
                   header = Controller::HeaderController)
      @context = context
      @header = create_header(header)
      @root = create_menu(root)
    end

    def audio_controller
      Mutex.new.synchronize do
        @audio_controller ||= Controller::AudioController.new(context)
      end
    end

    def bluetooth_controller
      Mutex.new.synchronize do
        @bluetooth_controller ||= Controller::BluetoothController.new(context)
      end
    end

    def header_controller
      Mutex.new.synchronize do
        @header_controller ||= Controller::HeaderController.new(context)
      end
    end

    def create_header(header_controller)
      x = header_controller.new(context)
      x.load_header
      x
    end

    def create_menu(root_controller)
      y = root_controller.new(context)
      y.load
      y
    end

    def load_ui
      # Vehicle::Display.instance.input_aux_heat
      header.load_header
      root.load
    end
  end
end
