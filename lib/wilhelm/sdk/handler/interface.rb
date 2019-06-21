# frozen_string_literal: false

module Wilhelm
  module SDK
    module Handler
      # Comment
      class InterfaceHandler < Core::BaseHandler
        include LogActually::ErrorOutput

        def initialize(application_context)
          @application_context = application_context
        end

        NAME = 'InterfaceHandler'.freeze

        def name
          NAME
        end

        def bus_online
          LOGGER.info(name) { 'Bus Online! Enabling ApplicationContext.' }
          LOGGER.debug(name) { 'Switching on Wilhelm...' }
          @application_context.online!
          LOGGER.debug(name) { 'Wilhelm is on! 👍' }
        end

        def bus_offline
          LOGGER.info(name) { 'Bus Offline! Disabling ApplicationContext.' }
          LOGGER.debug(name) { 'Switching off Wilhelm...' }
          @application_context.offline!
          LOGGER.debug(name) { 'Wilhelm is off! 👍' }
        end
      end
    end
  end
end
