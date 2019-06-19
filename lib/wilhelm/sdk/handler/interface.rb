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

        NAME = 'SDK::InterfaceHandler'.freeze

        def name
          NAME
        end

        def bus_online
          LOGGER.warn(name) { 'Bus Online! Enabling ApplicationContext.' }
          LOGGER.info(PROC) { 'Switching on Wilhelm...' }
          @application_context.online!
          LOGGER.info(PROC) { 'Wilhelm is on! 👍' }
        end

        def bus_offline
          LOGGER.warn(name) { 'Bus Offline! Disabling ApplicationContext.' }
          LOGGER.info(PROC) { 'Switching off Wilhelm...' }
          @application_context.offline!
          LOGGER.info(PROC) { 'Wilhelm is off! 👍' }
        end
      end
    end
  end
end
