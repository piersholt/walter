# frozen_string_literal: false

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          # HeaderController
          class HeaderController < UIKit::Controller::BaseController
            NAME = 'HeaderController'.freeze

            attr_reader :status_model

            def name
              NAME
            end

            # 'Pages' ------------------------------------------------------

            def header
              LOGGER.debug(NAME) { "#header" }
              view = View::Header::Status.new(status_model)
              render_header(view)
            end

            # Setup ------------------------------------------------------

            def create(view, create_argument = {})
              LOGGER.debug(NAME) { "#create(#{view}, #{create_argument})" }
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
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            rescue StandardError => e
              LOGGER.error(self.class.name) { e }
              e.backtrace.each { |line| LOGGER.error(self.class.name) { line } }
              LOGGER.error(self.class.name) { 'binding.pry start' }
              binding.pry
              LOGGER.error(self.class.name) { 'binding.pry end' }
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
                LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
                false
              end
            end

            # DATA EVENTS ------------------------------------------------------

            def status_update(action, model_object)
              LOGGER.debug(NAME) { "#status_update(#{action}, #{model_object})" }
              case action
              when :device_name
                header
              when :player_name
                header
              else
                LOGGER.debug(NAME) { "status_update: #{action} not implemented." }
              end
            end
          end
        end
      end
    end
  end
end
