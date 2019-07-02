# frozen_string_literal: false

require_relative 'context/ui'
require_relative 'context/notifications'
require_relative 'context/services'

module Wilhelm
  module SDK
    # SDK Container
    class Context
      attr_reader :services_context

      alias environment services_context

      def initialize(core_context)
        @services_context = ServicesContext.new
        setup_event_handling(core_context)
      end

      def close
        services_context.close
      end

      def setup_event_handling(core_context)
        core_listener = Listener::CoreListener.new
        core_listener
          .interface_handler = Handler::InterfaceHandler.new(services_context)
        core_context.interface.add_observer(core_listener)
      end
    end
  end
end
