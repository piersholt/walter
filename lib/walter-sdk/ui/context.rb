module Wolfgang
  class UserInterface
    class Context
      attr_accessor :application_context, :header, :service
      attr_reader :renderer
      alias context application_context

      # TODO: configuration file...
      ROOT_CONTROLLER = :debug

      def initialize(application_context, options = {
        renderer: Vehicle::Display.instance
      })
        @application_context = application_context
        @renderer = options[:renderer]
        # register_service_controller(:debug, )
      end

      def register_service_controllers(service_controller_hash)
        service_controller_hash.each do |name, klass|
          register_service_controller(name, klass)
        end
      end

      def register_service_controller(name, klass)
        LogActually.ui.debug('UIContext') { "#register_service_controller(#{name}, #{klass})" }
        service_controllers[name] = klass
      end

      def service_controllers
        @service_controllers ||= {}
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

      def launch(feature, action, args = nil)
        unless header
          # header.destroy if header
          header_controller = service_controllers[:header]
          @header = header_controller.new(self, application_context)
          @header.load(:header)
        end

        service&.destroy
        service_klass = service_controllers[feature]
        @service = service_klass.new(self, application_context) unless service.class === service_klass
        return service.load(action, args) if args
        service.load(action)
      end
    end
  end
end
