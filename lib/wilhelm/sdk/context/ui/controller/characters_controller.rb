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
                new_index = @code_model.backward
                LOGGER.debug(NAME) { "@code_model.backward => #{new_index}" }
                codelist
              when :page_next
                new_index = @code_model.forward
                LOGGER.debug(NAME) { "@code_model.forward => #{new_index}" }
                codelist
              when :weight_left
                new_index = @weight_model.shift(-1)
                LOGGER.debug(NAME) { "@weight_model.forward => #{new_index}" }
                weight
              when :weight_right
                new_index = @weight_model.shift(1)
                LOGGER.debug(NAME) { "@weight_model.forward => #{new_index}" }
                weight
              when :weight_less
                new_width = @weight_model.less!
                LOGGER.debug(NAME) { "@weight_model.fatter! => #{new_width}" }
                weight
              when :weight_more
                new_width = @weight_model.more!
                LOGGER.debug(NAME) { "@weight_model.fatter! => #{new_width}" }
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
