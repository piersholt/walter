# frozen_string_literal: false

require_relative 'context/ui'
require_relative 'context/notifications'

puts "\tLoading wilhelm/context"

require_relative 'context/constants'
require_relative 'context/logging'
require_relative 'context/states'
require_relative 'context/environment'
require_relative 'context/registration'
require_relative 'context/states/defaults'
require_relative 'context/states/offline'
require_relative 'context/states/online'
require_relative 'context/controls'

module Wilhelm
  module SDK
    class Context
      # Wilhelm Service
      class ServicesContext
        include Logging
        include Observable
        include Yabber::API
        include States
        include Environment
        include Registration
        include Controls

        attr_accessor :commands, :notifications

        def initialize
          @state = Offline.new
          connection_options = {
            port: ENV['client_port'],
            host: ENV['client_host']
          }
          logger.debug(WILHELM) { "Client connection options: #{connection_options}" }
          Yabber::Client.params(connection_options)
        end
      end
    end
  end
end
