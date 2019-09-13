# frozen_string_literal: true

module Wilhelm
  module Tools
    module Sniffer
      # Application Container
      class Application
        include Observable
        include Wilhelm::Virtual::Helpers::Console
        include ManageableThreads
        include Wilhelm::Core::Constants::Events::Application
        include Wilhelm::Helpers::Recovery

        attr_reader :core

        PROC = 'Sniffer'

        def initialize(opt_struct)
          @console = opt_struct.console
          @core = Wilhelm::Core::Context.new(self, opt_struct.file)
        end

        def launch
          LOGGER.debug(PROC) { '#launch' }

          Thread.current[:name] = 'Sniffer (Main)'
          start
          raise(NotImplementedError, 'Pry Console') if @console

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
          LOGGER.info(PROC) { 'Walter is closing!' }

          LOGGER.info(PROC) { "Publishing event: #{EXIT}" }
          changed
          notify_observers(EXIT, reason: 'bin')
          LOGGER.info(PROC) { "Subscribers updated! #{EXIT}" }

          LOGGER.info(PROC) { 'Turning stack off ⛔️' }
          stop
          LOGGER.info(PROC) { 'Stack is off 👍' }

          LOGGER.info(PROC) { 'See you anon ✌️' }
        end

        def start
          LOGGER.debug(PROC) { '#start' }
          @core.on
        end

        def stop
          LOGGER.debug(PROC) { '#stop' }
          @core.off
        end
      end
    end
  end
end
