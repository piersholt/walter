# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # Abstraction of UART interface
        class UART < SerialPortAdapter
          extend Forwardable
          include ManageableThreads
          include Configuration
          include Capture
          include State

          NAME = 'UART'.freeze
          THREAD_NAME = 'UART (Input Buffer)'

          def name
            NAME
          end

          def_delegators :private_input_buffer, *SizedQueue.instance_methods(false)
          def_delegators :private_input_buffer, *InputBuffer.instance_methods(false)
          def_delegator :private_input_buffer, :size

          def initialize(path)
            super(path)
            @serial_port.set_modem_params(BAUD, DATA_BITS, STOP_BITS, PARITY)
            @serial_port.flow_control = FLOW_CONTROL
          end

          def on
            LOGGER.info(NAME) { '#on' }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            online!
            capture!
          end

          def off
            LOGGER.info(NAME) { '#off' }
            close_threads
            close_capture
          end

          def write(string)
            string.length == super(string)
          end

          def write_nonblock(string)
            string.length == super(string)
          end

          # Backwards compatibility
          def input_buffer
            self
          end

          def output_buffer
            self
          end

          private

          def private_input_buffer
            @private_input_buffer ||= InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(NAME) { '#thread_populate_input_buffer' }
            Thread.new do
              Thread.current[:name] = THREAD_NAME
              read_byte = nil
              begin
                loop do
                  begin
                    read_byte = nil
                    read_byte = readpartial(1)
                    private_input_buffer.push(ByteBasic.new(read_byte))
                    capture_byte(read_byte)
                  rescue EncodingError
                    LOGGER.error(THREAD_NAME) { '#readpartial returned nil!' }
                  end
                end
              rescue EOFError
                LOGGER.warn(NAME) { "#{THREAD_NAME}: Stream reached EOF!" }
              rescue StandardError => e
                LOGGER.error(NAME) { "#{THREAD_NAME}: #{e}" }
                e.backtrace.each { |line| LOGGER.error(NAME) { line } }
              end
              LOGGER.warn(NAME) { "#{THREAD_NAME} thread is ending." }
            end
          end
        end
      end
    end
  end
end
