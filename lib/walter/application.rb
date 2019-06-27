# frozen_string_literal: true

module Walter
  # Application Container
  class Application
    include Observable
    include Wilhelm::Virtual::Helpers::Console
    include ManageableThreads
    include Wilhelm::Core::Constants::Events::Application

    attr_reader :core, :virtual, :api, :manager, :audio
    alias m manager
    alias a audio

    PROC = 'Walter'

    def initialize(file:, console:)
      @console = console

      @core = Wilhelm::Core::Context.new(self, file)
      @virtual = Wilhelm::Virtual::Context.new(self, @core)
      @api = Wilhelm::API::Context.new(virtual.bus)
      @sdk = Wilhelm::SDK::Context.new(@core)
      setup_services(@sdk.environment)

      apply_debug_defaults

      connection_options = {
        port: ENV['publisher_port'], host: ENV['publisher_host']
      }
      LOGGER.debug(PROC) { "Publisher connection options: #{connection_options}" }
      Publisher.params(connection_options)
      Publisher.announcement(:walter)
    end

    def launch
      LOGGER.debug(PROC) { '#launch' }
      Thread.current[:name] = 'Walter (Main)'
      begin
        start
        raise NotImplementedError, 'Pry Console' if @console

        LOGGER.debug 'Main Thread / Entering keep alive loop...'
        loop do
          news
          sleep 120
        end
      rescue NotImplementedError
        LOGGER.info(PROC) { 'Console start.' }
        binding.pry
        LOGGER.info(PROC) { 'Console end.' }
      rescue Interrupt
        LOGGER.debug 'Interrupt signal caught.'
      ensure
        LOGGER.info(PROC) { "Walter is closing!" }

        LOGGER.info(PROC) { "Publishing event: #{EXIT}" }
        changed
        notify_observers(EXIT, {reason: 'bin'})
        LOGGER.info(PROC) { "Subscribers updated! #{EXIT}" }

        LOGGER.info(PROC) { "Turning stack off ⛔️" }
        stop
        LOGGER.info(PROC) { "Stack is off 👍" }

        LOGGER.info(PROC) { "See you anon ✌️" }
      end
    end

    def start
      LOGGER.debug(PROC) { '#start' }
      @core.on
    end

    def stop
      LOGGER.debug(PROC) { '#stop' }
      LOGGER.info(PROC) { 'Switching off Wilhelm...' }
      @sdk.close
      LOGGER.info(PROC) { 'Wilhelm is off! 👍' }
      @core.off
    end

    private

    def setup_services(environment)
      @manager = Wilhelm::Services::Manager.new
      @audio = Wilhelm::Services::Audio.new

      manager.disable
      audio.disable

      environment.register_service(:manager, manager)
      environment.register_service(:audio, audio)
    end
  end
end
