# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Listener
      # Virtual::Listener::ApplicationListener
      class ApplicationListener < Core::BaseHandler
        include LogActually::ErrorOutput

        attr_accessor :display_handler

        def name
          'Virtual::ApplicationListener'
        end

        def update(action, properties)
          LOGGER.debug(name) { "#update(#{action}, #{properties})" }
          case action
          when EXIT
            LOGGER.debug(PROC) { "Delegate: #{@display_handler.class}" }
            display_handler&.exit(properties)
            LOGGER.debug(PROC) { "Delegate: #{@display_handler.class} complete!" }
          end
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(line) }
        end
      end
    end
  end
end
