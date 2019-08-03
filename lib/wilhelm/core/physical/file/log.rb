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
          include Errors

          NAME = 'Interface'.freeze
          THREAD_NAME = 'wilhelm-core/physical Log (Input Buffer)'

          def name
            NAME
          end

          # @override: ManageableThreads#proc_name
          alias proc_name name

          attr_reader :read_thread

          def_delegators :private_input_buffer, *SizedQueue.instance_methods(false)
          def_delegators :private_input_buffer, *Buffer::InputBuffer.instance_methods(false)
          def_delegator :private_input_buffer, :size

          def initialize(path)
            super(path, MODE)
          end

          def on
            LOGGER.debug(NAME) { '#on' }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            offline!
          end

          def off
            LOGGER.debug(NAME) { '#off' }
            close_threads
          end

          def write(*)
            raise TransmissionError, 'Device is log file. Cannot write to bus.'
          rescue TransmissionError => e
            LOGGER.warn(NAME) { e }
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
            @private_input_buffer ||= Buffer::InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(name) { 'New Thread: Byte Read.' }
            Thread.new do
              Thread.current[:name] = THREAD_NAME
              begin
                delay_defaults
                each_byte do |byte|
                  private_input_buffer.push(byte)
                  delay
                end
              rescue EOFError
                LOGGER.warn(name) { "#{THREAD_NAME}: Stream reached EOF!" }
              rescue StandardError => e
                LOGGER.error(name) { "#{THREAD_NAME}: #{e}" }
                e.backtrace.each { |line| LOGGER.error(name) { line } }
              end
              LOGGER.warn(name) { "#{THREAD_NAME} thread is ending." }
            end
          end
        end
      end
    end
  end
end
