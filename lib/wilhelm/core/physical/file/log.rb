# frozen_string_literal: true

module Wilhelm
  module Core
    class Interface
      module File
        # The binary stream stored as a local file for offline processing
        class Log < ::File
          extend Forwardable
          include ManageableThreads
          include Configuration
          include Wilhelm::Helpers::RateLimiter
          include State
          include Errors

          NAME             = 'File::Log'
          THREAD_NAME      = 'wilhelm-core/physical Log (Input Buffer)'
          LOG_ON           = '#on'
          LOG_OFF          = '#off'
          LOG_THREAD_START = 'New Thread: Log byte read.'
          LOG_THREAD_END   = "#{THREAD_NAME} thread is ending."
          ERROR_WRITE_NA   = 'Device is log file. Cannot write to bus.'

          def name
            NAME
          end

          # @override: ManageableThreads#proc_name
          alias proc_name name

          attr_reader :read_thread

          def_delegators(
            :private_input_buffer,
            *SizedQueue.instance_methods(false),
            *Buffer::InputBuffer.instance_methods(false),
            :size
          )

          def initialize(path)
            super(path, MODE)
          end

          def on
            LOGGER.debug(NAME) { LOG_ON }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            offline!
          end

          def off
            LOGGER.debug(NAME) { LOG_OFF }
            close_threads
          end

          def write(*)
            raise(TransmissionError, ERROR_WRITE_NA)
          rescue TransmissionError => e
            LOGGER.warn(NAME) { e }
          end

          alias write_nonblock write

          # Backwards compatibility
          alias input_buffer  itself
          alias output_buffer itself

          private

          def log
            :core
          end

          def private_input_buffer
            @private_input_buffer ||= Buffer::InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(NAME) { LOG_THREAD_START }
            Thread.new do
              Thread.current[:name] = THREAD_NAME
              begin
                delay_defaults
                each_byte do |byte|
                  private_input_buffer.push(byte)
                  # RateLimiter
                  delay
                end
              rescue EOFError
                LOGGER.warn(NAME) { "#{THREAD_NAME}: Stream reached EOF!" }
              rescue StandardError => e
                LOGGER.error(NAME) { "#{THREAD_NAME}: #{e}" }
                e.backtrace.each { |line| LOGGER.error(NAME) { line } }
              end
              LOGGER.warn(NAME) { LOG_THREAD_END }
            end
          end
        end
      end
    end
  end
end
