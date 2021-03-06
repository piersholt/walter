# frozen_string_literal: false

module Wilhelm
  module SDK
    module UIKit
      module Controller
        # SDK::UIKit::Controller::BaseController
        class BaseController
          attr_accessor :application_context, :ui_context
          alias context application_context
          attr_reader :view, :loaded_view

          LOGGER = LogActually.sdk

          def initialize(ui_context, application_context)
            LOGGER.info(name) { "#initialize (#{Thread.current})" }
            @ui_context = ui_context
            @application_context = application_context
          end

          def name
            'BaseController'
          end

          def load(action = :index, args = nil)
            @loaded_view = action
            args ? create(action, args) : create(action)
            public_send(action)
          end

          def launch(*args)
            ui_context.launch(*args)
          end

          def create(*args)
            raise("#create must be implemented by controllers. #{args}")
          end

          def destroy(*args)
            raise("#destroy must be implemented by controllers. #{args}")
          end

          def render_menu(view)
            ui_context.render_menu(view)
          end

          alias render render_menu

          def update_menu(view)
            ui_context.update_menu(view)
          end

          def render_header(view)
            ui_context.render_header(view)
          end
        end
      end
    end
  end
end
