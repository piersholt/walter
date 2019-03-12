# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class BaseController
        attr_accessor :context
        attr_writer :renderer
        attr_reader :view

        # def logger
        #   LogActually.wolfgang
        # end

        def initialize(context)
          LogActually.ui.info(name) { "#initialize (#{Thread.current})" }
          @context = context
        end

        def renderer
          @renderer ||= Vehicle::Display.instance
        end

        def name
          'BaseController'
        end

        def render(view)
          renderer.render_menu(view)
        end

        def load(action = :index)
          create(action)
          public_send(action)
        end

        def load_header(action = :header)
          create(action)
          public_send(action)
        end
      end
    end
  end
end
