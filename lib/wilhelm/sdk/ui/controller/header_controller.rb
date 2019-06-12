# frozen_string_literal: false

module Wilhelm::SDK
  class UserInterface
    module Controller
      # Comment
      class HeaderController < BaseController
        NAME = 'HeaderController'.freeze

        attr_reader :status_model

        def name
          NAME
        end

        # 'Pages' ------------------------------------------------------

        def header
          LogActually.ui.debug(NAME) { "#header" }
          view = View::Header::Status.new(status_model)
          render_header(view)
        end

        # Setup ------------------------------------------------------

        def create(view, create_argument = {})
          LogActually.ui.debug(NAME) { "#create(#{view}, #{create_argument})" }
          case view
          when :header
            player_object = context.audio.player
            devices_object = context.manager.devices

            @status_model = Model::Header::Status.new
            status_model.player(player_object)

            player_object.add_observer(status_model, :player_update)
            devices_object.add_observer(status_model, :devices_update)

            status_model.add_observer(self, :status_update)
            true
          else
            LogActually.ui.warn(NAME) { "Create: #{view} view not recognised." }
            false
          end
        rescue StandardError => e
          LogActually.ui.error(self.class.name) { e }
          e.backtrace.each { |line| LogActually.ui.error(self.class.name) { line } }
          LogActually.ui.error(self.class.name) { 'binding.pry start' }
          binding.pry
          LogActually.ui.error(self.class.name) { 'binding.pry end' }
        end

        def destroy
          case :header
          when :header
            return false unless status_model
            player_object = context.audio.player
            devices_object = context.manager.devices

            player_object.delete_observer(status_model)
            devices_object.delete_observer(status_model)

            status_model.delete_observer(self)
            true
          else
            LogActually.ui.warn(NAME) { "Destroy: #{view} view not recognised." }
            false
          end
        end

        # DATA EVENTS ------------------------------------------------------

        def status_update(action, model_object)
          LogActually.ui.debug(NAME) { "#status_update(#{action}, #{model_object})" }
          case action
          when :device_name
            header
          when :player_name
            header
          else
            LogActually.ui.debug(NAME) { "status_update: #{action} not implemented." }
          end
        end

      end
    end
  end
end
