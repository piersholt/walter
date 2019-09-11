# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Core::DataLink::Receiver
      class Receiver
        include Observable
        include ManageableThreads
        include Constants
        include Errors

        NAME = 'Receiver'
        THREAD_NAME = 'wilhelm-core/data_link Receiver (Input Buffer)'

        attr_reader :input_buffer, :output_buffer, :read_thread

        def initialize(input_buffer, synchronisation = Synchronisation::Instrument)
          @input_buffer = input_buffer
          @output_buffer = SizedQueue.new(32)
          @synchronisation = synchronisation
        end

        def name
          NAME
        end

        # @override: ManageableThreads#proc_name
        alias proc_name name

        def off
          LOGGER.debug(name) { "#{self.class}#off" }
          close_threads
        end

        def on
          LOGGER.debug(name) { "#{self.class}#on" }
          @read_thread = thread_read_buffer(@input_buffer, @output_buffer)
          add_thread(@read_thread)
          true
        rescue StandardError => e
          LOGGER.error(e)
          e.backtrace.each { |l| LOGGER.error(l) }
          raise e
        end

        private

        # ------------------------------ THREADS ------------------------------ #

        def thread_read_buffer(input_buffer, output_buffer)
          LOGGER.debug(name) { 'New Thread: Frame Read.' }
          Thread.new do
            Thread.current[:name] = THREAD_NAME
            synchronisation(input_buffer)
            LOGGER.warn(name) { "#{self.class} thread is finished..!" }
          end
        end

        TRUE = true

        def synchronisation(input_buffer)
          LOGGER.debug(name) { 'Entering byte shift loop.' }
          synchronise_frame(input_buffer) while TRUE
        rescue StandardError => e
          LOGGER.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
          e.backtrace.each { |l| LOGGER.error(l) }
          binding.pry
        end

        def synchronise_frame(input_buffer)
          synchronisation = @synchronisation.new(input_buffer)
          new_frame = synchronisation.run
          LOGGER.debug(name) { "Frame: #{new_frame}" }
          output_buffer.push(new_frame)
        rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
          LOGGER.warn(name) { "#{e}!" }
          clean_up(input_buffer, synchronisation.frame)
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.warn(line) }
          clean_up(input_buffer, synchronisation.frame)
          binding.pry
        end

        def clean_up(buffer, new_frame)
          LOGGER.debug(name) { "#{SYNC_ERROR} #clean_up" }
          byte_to_discard = new_frame[0]
          LOGGER.warn(name) { "#{SYNC_SHIFT} Drop: #{byte_to_discard}." }

          bytes_to_unshift = new_frame[1..-1]
          LOGGER.debug(name) { "#{SYNC_SHIFT} Returning to buffer: #{bytes_to_unshift.length} bytes." }
          LOGGER.debug(name) { "#{SYNC_SHIFT} Returning to buffer: #{bytes_to_unshift.first(10)}....." }

          buffer.unshift(*bytes_to_unshift)
        end
      end
    end
  end
end
