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
          THREAD_NAME = 'wilhelm-core/physical UART (Input Buffer)'

          def name
            NAME
          end

          # @override: ManageableThreads#proc_name
          alias proc_name name

          def_delegators :private_input_buffer, *SizedQueue.instance_methods(false)
          def_delegators :private_input_buffer, *Buffer::InputBuffer.instance_methods(false)
          def_delegator :private_input_buffer, :size

          def initialize(path)
            super(path)
            @serial_port.set_modem_params(BAUD, DATA_BITS, STOP_BITS, PARITY)
            @serial_port.flow_control = FLOW_CONTROL
          end

          def on
            LOGGER.debug(NAME) { '#on' }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            online!
            capture!
          end

          def off
            LOGGER.debug(NAME) { '#off' }
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
            @private_input_buffer ||= Buffer::InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(NAME) { 'New Thread: Byte Read' }
            Thread.new do
              Thread.current[:name] = THREAD_NAME
              begin
                each_byte do |byte|
                  private_input_buffer.push(byte)
                  capture_byte(byte.chr(Encoding::ASCII_8BIT))
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
