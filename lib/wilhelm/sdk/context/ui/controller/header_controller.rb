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
                devices_object = context.manager.devices
                audio_service = context.audio

                @status_model = Model::Header::Status.new
                status_model.device(devices_object.connected.first) if devices_object.connected?
                status_model.volume(audio_service.level)

                devices_object.add_observer(status_model, :devices_update)
                audio_service.add_observer(status_model, :audio_update)

                status_model.add_observer(self, :status_update)
                true
              else
                LOGGER.warn(NAME) { "Create: #{view} view not recognised." }
                false
              end
            rescue StandardError => e
              LOGGER.error(NAME) { e }
              e.backtrace.each { |line| LOGGER.error(NAME) { line } }
            end

            def destroy
              LOGGER.debug(NAME) { '#destroy' }
              case loaded_view
              when :header
                return false unless @status_model
                LOGGER.debug(NAME) { '#destroy => :header' }
                devices_object = context.manager.devices
                audio_service = context.audio

                devices_object&.delete_observer(status_model)
                audio_service&.delete_observer(status_model)
                status_model&.delete_observer(self)
                @status_model = nil
                true
              else
                LOGGER.warn(NAME) { "Destroy: #{view} view not recognised." }
                false
              end
            end

            # DATA EVENTS ------------------------------------------------------

            def status_update(action, model_object)
              LOGGER.unknown(NAME) { "#status_update(#{action}, #{model_object})" }
              case action
              when :device_name
                header
              when :player_name
                header
              when :volume_level
                header
              else
                LOGGER.unknown(NAME) { "status_update: #{action} not implemented." }
              end
            end
          end
        end
      end
    end
  end
end
