# frozen_string_literal: false

module Wolfgang
  class UserInterface
    module Controller
      # Comment
      class HeaderController < BaseController
        NAME = 'HeaderController'.freeze

        def name
          NAME
        end

        # 'Pages' ------------------------------------------------------

        def header
          LogActually.ui.unknown(NAME) { '#header' }
          view = View::Header::Status.new
          render_header(view)
        end

        # Setup ------------------------------------------------------

        def create(view, selected_menu_item: nil)
          LogActually.ui.debug(NAME) { "#create(#{view})" }
          case view
          when :header
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        end

        def destroy(view)
          case view
          when :header
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # USER EVENTS ------------------------------------------------------
        # none
        # DATA EVENTS ------------------------------------------------------
        # none
      end
    end
  end
end
