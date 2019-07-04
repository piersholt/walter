# frozen_string_literal: true

puts "\tLoading wilhelm/context/services"

require_relative 'services/constants'
require_relative 'services/logging'
require_relative 'services/states'
require_relative 'services/environment'
require_relative 'services/registration'
require_relative 'services/states/defaults'
require_relative 'services/states/offline'
require_relative 'services/states/online'
require_relative 'services/controls'

module Wilhelm
  module SDK
    class Context
      # Wilhelm Service
      class ServicesContext
        include Logging
        include Observable
        include Messaging::API
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
          Client.params(connection_options)
        end
      end
    end
  end
end
