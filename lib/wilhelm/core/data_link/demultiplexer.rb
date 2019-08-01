# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Core::DataLink::Demultiplexer
      class Demultiplexer
        include Observable
        include ManageableThreads
        include Constants::Events

        NAME = 'Demultiplexer'
        THREAD_NAME = 'wilhelm-core/data_link Demultiplexer (Input Buffer)'

        attr_reader :input_buffer, :output_buffer, :read_thread

        # @todo remove output buffer given use of Observerable
        def initialize(input_buffer)
          @input_buffer = input_buffer
          @output_buffer = SizedQueue.new(32)
        end

        def on
          LOGGER.debug(name) { '#on' }
          @read_thread = thread_read_input_frame_buffer(@input_buffer, @output_buffer)
          add_thread(@read_thread)
          true
        rescue StandardError => e
          LOGGER.error(e)
          e.backtrace.each { |line| LOGGER.error(name) { line } }
          raise e
        end

        def off
          LOGGER.debug(name) { '#off' }
          close_threads
        end

        private

        def name
          NAME
        end

        # @override: ManageableThreads#proc_name
        alias proc_name name

        LOG_THREAD_START = 'New Thread: Frame Demultiplexing'
        LOG_THREAD_END = 'End Thread: Frame Demultiplexing'

        def thread_read_input_frame_buffer(input_buffer, output_buffer)
          LOGGER.debug(name) { LOG_THREAD_START }
          Thread.new do
            Thread.current[:name] = THREAD_NAME
            begin
              loop do
                new_frame = input_buffer.pop
                new_data = demultiplex(new_frame)
                distribute(new_data)
              end
            rescue StandardError => e
              LOGGER.error(name) { e }
              e.backtrace.each { |line| LOGGER.error(name) { line } }
            end
            LOGGER.warn(name) { LOG_THREAD_END }
          end
        end

        def demultiplex(frame)
          LOGGER.debug(name) { "#demultiplex(#{frame})" }
          from    = frame.from.to_i
          to      = frame.to.to_i
          payload = frame.payload

          data = Data.new(from, to, payload)
          LOGGER.debug(name) { "Data build: #{data}" }
          data
        rescue TypeError => e
          LOGGER.error(name) { e }
          LOGGER.error(name) { e.cause }
          e.backtrace.each { |line| LOGGER.error(name) { line } }
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(name) { line } }
        end

        def distribute(new_data)
          LOGGER.debug(name) { "Notify: #{DATA_RECEIVED}, #{new_data}. (#{Thread.current})" }
          changed
          notify_observers(DATA_RECEIVED, data: new_data)
        end
      end
    end
  end
end
