# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module File
        # The binary stream stored as a local file for offline processing
        class Log < ::File
          extend Forwardable
          include ManageableThreads
          include Configuration
          include Wilhelm::Helpers::Delayable
          include State

          NAME = 'Capture'.freeze
          
          def name
            NAME
          end

          def_delegators :private_input_buffer, *SizedQueue.instance_methods(false)
          def_delegators :private_input_buffer, *InputBuffer.instance_methods(false)
          def_delegator :private_input_buffer, :size

          def initialize(path)
            super(path, MODE)
          end

          def on
            LOGGER.warn(NAME) { '#on' }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            offline!
          end

          def off
            LOGGER.warn(NAME) { '#off' }
            close_threads
          end

          def write(*)
            raise TransmissionError, 'Device is log file. Cannot write to bus.'
          end

          alias write_nonblock write

          # Backwards compatibility
          def input_buffer
            self
          end

          def output_buffer
            self
          end

          private

          def log
            :core
          end

          def private_input_buffer
            @private_input_buffer ||= InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(PROC) { '#thread_populate_input_buffer' }
            Thread.new do
              thread_name = 'Log (Input Buffer)'
              Thread.current[:name] = thread_name
              read_byte = nil
              i = 1
              begin
                delay_defaults
                loop do
                  begin
                    read_byte = nil
                    read_byte = readpartial(1)
                    raise EncodingError if read_byte.nil?
                    byte_basic = ByteBasic.new(read_byte)
                    private_input_buffer.push(byte_basic)
                    delay
                  rescue EncodingError
                    LOGGER.error(thread_name) { '#readpartial returned nil!' }
                  end
                end
              rescue EOFError
                LOGGER.warn(PROC) { "#{thread_name}: Stream reached EOF!" }
              rescue StandardError => e
                LOGGER.error(PROC) { "#{thread_name}: #{e}" }
                e.backtrace.each { |line| LOGGER.error(PROC) { line } }
              end
              LOGGER.warn(PROC) { "#{thread_name} thread is ending." }
            end
          end
        end
      end
    end
  end
end
