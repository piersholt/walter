# frozen_string_literal: true

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

          NAME    = 'UART'
          LOG_ON  = '#on'
          LOG_OFF = '#off'

          THREAD_NAME      = 'wilhelm-core/physical UART (Input Buffer)'
          LOG_THREAD_START = 'New Thread: Byte Read'
          LOG_THREAD_END   = "#{THREAD_NAME} thread is ending."

          def name
            NAME
          end

          # @override: ManageableThreads#proc_name
          alias proc_name name

          def_delegators(
            :private_input_buffer,
            *SizedQueue.instance_methods(false),
            *Buffer::InputBuffer.instance_methods(false),
            :size
          )

          def initialize(path)
            super(path)
            @serial_port.set_modem_params(BAUD, DATA_BITS, STOP_BITS, PARITY)
            @serial_port.flow_control = FLOW_CONTROL
          end

          def on
            LOGGER.debug(NAME) { LOG_ON }
            @read_thread = thread_populate_input_buffer
            add_thread(@read_thread)
            online!
            capture!
          end

          def off
            LOGGER.debug(NAME) { LOG_OFF }
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
          alias input_buffer  itself
          alias output_buffer itself

          private

          def private_input_buffer
            @private_input_buffer ||= Buffer::InputBuffer.new
          end

          def thread_populate_input_buffer
            LOGGER.debug(NAME) { LOG_THREAD_START }
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
              LOGGER.warn(NAME) { LOG_THREAD_END }
            end
          end
        end
      end
    end
  end
end
