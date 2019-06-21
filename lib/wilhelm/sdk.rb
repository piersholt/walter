# frozen_string_literal: true

puts 'Loading wilhelm/sdk'

LogActually.is_all_around(:sdk)

LogActually.sdk.i

module Wilhelm
  module SDK
    LOGGER = LogActually.sdk
  end
end

require_relative 'sdk/controls'
require_relative 'sdk/ui'
require_relative 'sdk/notifications'
require_relative 'sdk/nodes'
require_relative 'sdk/environment'
require_relative 'sdk/listener'
require_relative 'sdk/handler'
require_relative 'sdk/context'

puts "\tDone!"
