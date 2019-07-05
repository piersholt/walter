# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          # CharactersController
          class CharactersController < UIKit::Controller::BaseController
            NAME = 'CharactersController'

            def codelist
              LOGGER.unknown(NAME) { '#codelist' }
              @view = View::Characters::CodeList.new(@code_model)
              view.add_observer(self)

              render(view)
            end

            def weight
              LOGGER.unknown(NAME) { '#weight' }
              @view = View::Characters::Weight.new(@weight_model)
              view.add_observer(self)

              render(view)
            end

            def name
              NAME
            end

            # Setup --------------------------------d----------------------

            def create(view)
              LOGGER.warn(NAME) { "#create(#{view})" }
              case view
              when :codelist
                @code_model = Model::Characters::CodeList.new(32, 8)
                true
              when :weight
                @weight_model = Model::Characters::Weight.new(16, 0, 5)
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            end

            def destroy
              case loaded_view
              when :codelist
                @code_model = nil
                true
              when :weight
                @weight_model = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
                false
              end
            end

            # SYSTEM EVENTS ------------------------------------------------------

            # USER EVENTS ------------------------------------------------------

            def update(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.class})" }
              case action
              when :page_previous
                LOGGER.debug(NAME) { "backward => #{@code_model.backward}" }
                codelist
              when :page_next
                LOGGER.debug(NAME) { "forward => #{@code_model.forward}" }
                codelist
              when :weight_left
                LOGGER.debug(NAME) { "shift(-1) => #{@weight_model.shift(-1)}" }
                weight
              when :weight_right
                LOGGER.debug(NAME) { "shift(1) => #{@weight_model.shift(1)}" }
                weight
              when :weight_less
                LOGGER.debug(NAME) { "less! => #{@weight_model.less!}" }
                weight
              when :weight_more
                LOGGER.debug(NAME) { "more! => #{@weight_model.more!}" }
                weight
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end
          end
        end
      end
    end
  end
end
