# frozen_string_literal: true

module Wilhelm
  module Core
    module Listener
      # Comment
      class ApplicationListener < BaseListener
        include LogActually::ErrorOutput

        NAME = 'ApplicationListener'

        def name
          NAME
        end

        attr_accessor :data_logging_handler

        def initialize(data_logging_handler: nil)
          @data_logging_handler = data_logging_handler
        end

        def update(action, properties)
          LOGGER.warn(name) { "ApplicationListener disabled!" }
          return false
          LOGGER.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when EXIT
            LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class}" }
            data_logging_handler&.exit
            LOGGER.debug(name) { "Delegate: #{@data_logging_handler.class} complete!" }
          end
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(line) }
        end
      end
    end
  end
end
