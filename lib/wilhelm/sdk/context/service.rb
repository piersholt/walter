# frozen_string_literal: true

# Top level namespace
module Wilhelm::SDK
  # Wilhelm Service
  class ApplicationContext
    include Logging
    include Constants
    include Observable
    include Messaging::API
    include Controls
    include Nodes

    attr_reader :state

    attr_accessor :commands, :notifications
    attr_writer :ui

    def initialize
      @state = Offline.new
      connection_options =
        { port: ENV['client_port'],
          host: ENV['client_host'] }
      logger.warn(WILHELM) { "Client connection options: #{connection_options}" }
      Client.params(connection_options)
    end

    # STATES -------------------------------------------------------------

    def change_state(new_state)
      logger.info(WILHELM) { "state change => #{new_state.class}" }
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
