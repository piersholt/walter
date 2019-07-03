# frozen_string_literal: true

puts "\tLoading wilhelm/context/services"

require_relative 'services/constants'
require_relative 'services/logging'
require_relative 'services/states/defaults'
require_relative 'services/states/offline'
require_relative 'services/states/online'
require_relative 'services/controls'

# Top level namespace
module Wilhelm
  module SDK
    class Context
      # Wilhelm Service
      class ServicesContext
        include Logging
        include Observable
        include Messaging::API
        include Controls

        attr_reader :state

        attr_accessor :commands, :notifications
        attr_writer :ui

        def initialize
          @state = Offline.new
          connection_options = {
            port: ENV['client_port'],
            host: ENV['client_host']
          }
          logger.debug(WILHELM) { "Client connection options: #{connection_options}" }
          Client.params(connection_options)
        end

        # STATES -------------------------------------------------------------

        def change_state(new_state)
          logger.info(WILHELM) { "State => #{new_state.class}" }
          @state = new_state
          changed
          notify_observers(state)
          @state
        end

        def online!
          @state.online!(self)
        end

        def offline!
          @state.offline!(self)
        end

        # METHODS -------------------------------------------------------------

        def alive?
          @state.alive?(self)
        end

        alias open online!
        alias close offline!

        # APPLICATION CONTEXT -----------------------------------------------------

        def ui
          semaphore.synchronize do
            @ui
          end
        end

        def notifications!
          @state.notifications!(self)
        end

        def ui!
          @state.ui!(self)
        end

        # SERVICES ----------------------------------------------------------------

        def inst_var(name)
          name_string = name.id2name
          '@'.dup.concat(name_string).to_sym
        end

        def services
          @services ||= []
        end

        def register_service(service_name, service_object)
          add_observer(service_object, :state_change)
          instance_variable_set(inst_var(service_name), service_object)
          services << service_object
          self.class.class_eval do
            attr_reader service_name
          end
        end

        private

        def semaphore
          @semaphore ||= Mutex.new
        end
      end
    end
  end
end
