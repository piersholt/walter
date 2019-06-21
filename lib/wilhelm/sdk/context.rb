# frozen_string_literal: false

module Wilhelm
  module SDK
    # SDK Container
    class Context
      attr_reader :environment

      def initialize(core_context)
        @environment = Environment.new
        setup_event_handling(core_context)
      end

      def setup_event_handling(core_context)
        core_listener = Listener::CoreListener.new
        core_listener
          .interface_handler = Handler::InterfaceHandler.new(environment)
        core_context.interface.add_observer(core_listener)
      end
    end
  end
end
