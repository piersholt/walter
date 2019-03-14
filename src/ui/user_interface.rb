module Wolfgang
  class UIContext
    attr_accessor :application_context
    attr_reader :renderer
    alias context application_context

    def initialize(application_context, options = { renderer: Vehicle::Display.instance })
      @application_context = application_context
      @renderer = options[:renderer]
    end

    def to_s
      '<UserInterface>'
    end

    def inspect
      '<UserInterface>'
    end

    def render_menu(view)
      renderer.render_menu(view)
    end

    def render_header(view)
      renderer.render_new_header(view)
    end

    alias render render_menu
  end
end

# TODO: make this programtic
# new UI context with which controllers, and root are configured
module Wolfgang
  class UserInterface
    class ApplicationUI < UIContext
      attr_accessor :header, :service

      # TODO: configuration file...
      SERVICE_CONTROLLERS = {
        header: Controller::HeaderController,
        debug: Controller::DebugController,
        audio: Controller::AudioController,
        bluetooth: Controller::BluetoothController
      }.freeze

      # TODO: configuration file...
      ROOT_CONTROLLER = :debug

      def launch(feature, action, args = nil)
        unless header
          # header.destroy if header
          header_controller = SERVICE_CONTROLLERS[:header]
          @header = header_controller.new(self, application_context)
          @header.load(:header)
        end

        service&.destroy
        service_klass = SERVICE_CONTROLLERS[feature]
        @service = service_klass.new(self, application_context) unless service.class === service_klass
        return service.load(action, args) if args
        service.load(action)
      end

      # def load_ui
      #   Vehicle::Display.instance.input_aux_heat
      #   header.load_header
      #   service.load
      # end

      # def load_audio
      #   header.load_header
      #   audio_controller.reload(:index)
      # end

      # def audio_controller
      #   Mutex.new.synchronize do
      #     @audio_controller ||= Controller::AudioController.new(application_context)
      #   end
      # end
      #
      # def bluetooth_controller
      #   Mutex.new.synchronize do
      #     @bluetooth_controller ||= Controller::BluetoothController.new(application_context)
      #   end
      # end
      #
      # def header_controller
      #   Mutex.new.synchronize do
      #     @header_controller ||= Controller::HeaderController.new(application_context)
      #   end
      # end
    end
  end
end
