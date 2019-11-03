# frozen_string_literal: true

puts "\tLoading wilhelm/sdk/notifications"

require_relative 'notifications/constants'
require_relative 'notifications/states/inactive'
require_relative 'notifications/states/active'
require_relative 'notifications/listener'
require_relative 'notifications/context_handler'

module Wilhelm
  module SDK
    class Context
      # Context::Notifications
      class Notifications
        include LogActually::ErrorOutput
        attr_accessor :listener, :handler, :context
        attr_writer :bus

        alias environment context

        include Constants

        def initialize(context)
          @context = context
          @state = Inactive.new
        end

        def bus
          context.bus
        end

        def start
          logger.debug(NOTIFICATIONS) { '#start' }
          @state.start(self)
        end

        def stop
          logger.debug(NOTIFICATIONS) { '#stop' }
          @state.stop(self)
        end

        def change_state(new_state)
          logger.debug(NOTIFICATIONS) { "State => #{new_state.class}" }
          @state = new_state
        end

        def registered_handlers
          @registered_handlers ||= []
        end

        def register_handlers(*handlers)
          logger.debug(NOTIFICATIONS) { "#register_handlers(#{handlers})" }
          handlers.each do |handler|
            registered_handlers << handler
          end
        end
      end
    end
  end
end
