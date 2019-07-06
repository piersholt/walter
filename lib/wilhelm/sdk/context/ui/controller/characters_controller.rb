# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          # CharactersController
          class CharactersController < UIKit::Controller::BaseController
            NAME = 'CharactersController'

            CHARACTERS = [
              { label: 'Character Set', action: :codelist },
              { label: 'Font Width', action: :weight },
              { label: 'Control Characters', action: :control }
            ].freeze

            def index
              LOGGER.unknown(NAME) { '#index' }
              @view = View::Characters::Index.new(CHARACTERS)
              view.add_observer(self)

              render(view)
            end

            def codelist
              LOGGER.unknown(NAME) { '#codelist' }
              @view = View::Characters::CodeList.new(@code_model)
              view.add_observer(self, :update_codelist)

              render(view)
            end

            def weight
              LOGGER.unknown(NAME) { '#weight' }
              @view = View::Characters::Weight.new(@weight_model)
              view.add_observer(self, :update_weight)

              render(view)
            end

            def control
              LOGGER.unknown(NAME) { '#control' }
              # LOGGER.unknown(NAME) { "@control_model => #{@control_model.instance_variable_get(:@items)}" }
              @view = View::Characters::ControlCharacters.new(@control_model)
              view.add_observer(self, :update_control)

              render(view)
            end

            def name
              NAME
            end

            # Setup --------------------------------d----------------------

            def create(view)
              LOGGER.warn(NAME) { "#create(#{view})" }
              case view
              when :index
                true
              when :codelist
                @code_model = Model::Characters::CodeList.new(32, 8)
                true
              when :weight
                @weight_model = Model::Characters::Weight.new(16, 0, 5)
                true
              when :control
                @control_model = Model::Characters::ControlCharacters.new(0, 5)
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            end

            def destroy
              case loaded_view
              when :index
                true
              when :codelist
                @code_model = nil
                true
              when :weight
                @weight_model = nil
                true
              when :control
                @control_model = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
                false
              end
            end

            # USER EVENTS ------------------------------------------------------

            def update(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update(#{action}, #{selected_menu_item.class})" }
              case action
              when :codelist
                launch(:characters, :codelist)
              when :weight
                launch(:characters, :weight)
              when :control
                launch(:characters, :control)
              when :debug_index
                launch(:debug, :index)
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            def update_codelist(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update_codelist(#{action}, #{selected_menu_item.class})" }
              case action
              when :page_previous
                result = @code_model.backward
                LOGGER.debug(NAME) { "backward => #{result}" }
                codelist
              when :page_next
                result = @code_model.forward
                LOGGER.debug(NAME) { "forward => #{result}" }
                codelist
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            def update_weight(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update_weight(#{action}, #{selected_menu_item.class})" }
              case action
              when :weight_left
                result = @weight_model.shift(-1)
                LOGGER.debug(NAME) { "shift(-1) => #{result}" }
                weight
              when :weight_right
                result = @weight_model.shift(1)
                LOGGER.debug(NAME) { "shift(1) => #{result}" }
                weight
              when :weight_less
                result = @weight_model.less!
                LOGGER.debug(NAME) { "less! => #{result}" }
                weight
              when :weight_more
                result = @weight_model.more!
                LOGGER.debug(NAME) { "more! => #{result}" }
                weight
              else
                LOGGER.debug(NAME) { "#update: #{action} not implemented." }
              end
            end

            def update_control(action, selected_menu_item = nil)
              LOGGER.debug(NAME) { "#update_control(#{action}, #{selected_menu_item.class})" }
              case action
              when :control_left
                result = @control_model.backward
                LOGGER.debug(NAME) { "backward => #{result}" }
                control
              when :control_right
                result = @control_model.forward
                LOGGER.debug(NAME) { "forward => #{result}" }
                control
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
