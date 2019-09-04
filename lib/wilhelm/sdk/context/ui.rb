# frozen_string_literal: true

require_relative 'ui/constants'
require_relative 'ui/model'
require_relative 'ui/view'
require_relative 'ui/controller'

module Wilhelm
  module SDK
    class Context
      # SDK::Context::UserInterface
      class UserInterface
        include Helpers::Observation
        attr_accessor :application_context, :header, :service
        attr_reader :renderer
        alias context application_context

        LOGGER = LogActually.sdk

        PROG = 'Context::UI'
        OPTS = { renderer: Wilhelm::API::Display.instance }.freeze

        def initialize(application_context, options = OPTS)
          @application_context = application_context
          @renderer = options[:renderer]
          renderer.add_observer(self, :renderer_update)
        end

        def to_s
          '<SDK::Context::UserInterface>'
        end

        def inspect
          "#<#{self.class} @header=#{header} @service=#{service}>"
        end

        def launch(controller, action, args = nil)
          LOGGER.debug(PROG) { "#launch(#{controller}, #{action}, #{args})" }
          LOGGER.debug(PROG) { "header?(controller) || !header? => #{header?(controller) || !header?}" }
          load_header(args) if header?(controller) || !header?
          load_service(controller, action, args)
        rescue StandardError => e
          LOGGER.error(PROG) { e }
          e.backtrace.each { |line| LOGGER.error(PROG) { line } }
        end

        def renderer_update(new_state)
          LOGGER.debug(PROG) { "#renderer_update(#{new_state.class})" }
          case new_state
          when :destroy
            emit_destroy
          when API::Display::Busy
            emit_destroy
          when API::Display::Disabled
            emit_destroy
          end
        end

        def emit_destroy
          LOGGER.debug(PROG) { '#emit_destroy' }
          header&.destroy
          @header = nil
          service&.destroy
        end

        # REGISTRATION

        # Services to register their controllers
        def register_service_controllers(service_controller_hash)
          service_controller_hash.each do |name, klass|
            register_service_controller(name, klass)
          end
        end

        def register_service_controller(name, klass)
          LOGGER.debug(PROG) do
            "#register_service_controller(#{name}, #{klass})"
          end
          service_controllers[name] = klass
        end

        def service_controllers
          @service_controllers ||= {}
        end

        # BASE CONTROLLER

        # Called by UIKit::Controller::BaseController
        def render_menu(view)
          renderer.render_menu(view)
        end

        alias render render_menu

        # Called by UIKit::Controller::BaseController
        def render_header(view)
          renderer.render_header(view)
        end

        private

        def header?(controller = nil)
          return controller == :header if controller
          @header ? true : false
        end

        def klass(controller)
          controller_klass = service_controllers[controller]
          raise(LoadError, "No service controller for: #{controller}!. Controllers are: #{service_controllers.keys}") unless controller_klass
          controller_klass
        end

        def load_header(args = nil)
          LOGGER.debug(PROG) { "#load_header(#{args})" }
          LOGGER.debug(PROG) { "header&.destroy => #{header&.destroy}" }
          header&.destroy
          controller_klass = klass(:header)
          @header = controller_klass.new(self, application_context)
          return header.load(:header, args) if args
          header.load(:header)
        end

        def load_service(controller, action, args = nil)
          LOGGER.debug(PROG) { "#load_service(#{controller}, #{action}, #{args})" }
          LOGGER.debug(PROG) { "service&.destroy => #{service&.destroy}" }
          service&.destroy
          controller_klass = klass(controller)
          @service = controller_klass.new(self, application_context)
          return service.load(action, args) if args
          service.load(action)
        end
      end
    end
  end
end
