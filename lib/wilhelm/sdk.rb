# frozen_string_literal: true

puts 'Loading wilhelm/sdk'

LogActually.is_all_around(:sdk)

LogActually.sdk.i

module Wilhelm
  module SDK
    LOGGER = LogActually.sdk
  end
end

require_relative 'sdk/ui'
require_relative 'sdk/controls'
require_relative 'sdk/listener'
require_relative 'sdk/handler'
require_relative 'sdk/context'

module Wilhelm
  # SDK Interface
  module SDK
    extend self

    def context(core_context)
      sdk_context = Context::ServicesContext.new
      setup_event_handling(core_context, sdk_context)
      sdk_context
    end

    def setup_event_handling(core_context, sdk_context)
      core_listener = Listener::CoreListener.new
      core_listener
        .interface_handler = Handler::InterfaceHandler.new(sdk_context)
      core_context.interface.add_observer(core_listener)
    end
  end
end

puts "\tDone!"
