# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class Interface
      include Observable
      include ManageableThreads
      include Wilhelm::Helpers::Delayable

      FILE_TYPE = { tty: 'characterSpecial', file: 'file', fifo: 'fifo' }.freeze
      FILE_TYPE_HANDLERS = { tty: Interface::UART, file: Interface::File }.freeze
      DEFAULT_PATH = '/dev/cu.SLAB_USBtoUART'.freeze
      NO_OPTIONS = {}.freeze

      PROC = 'Interface'.freeze

      attr_reader :input_buffer, :output_buffer, :read_thread

      def name
        Thread.current[:name]
      end

      # @override Delayable#log
      def log
        :core
      end

      # @override: ManageableThreads#proc_name
      alias proc_name name

      # The interface should protect the interface from the implementation.
      # i shouldn't be forwarding methods.. that's what bit me with rubyserial
      # i was tried to the API of the library.. and not protected for it
      # it's responsible for a consistent APi. how #read is implemented

      def initialize(path, options = NO_OPTIONS)
        @stream = parse_path(path, options)

        @input_buffer = InputBuffer.new
        @output_buffer = OutputBuffer.new(@stream)
      end

      def on
        offline?

        @read_thread = thread_populate_input_buffer(@stream, @input_buffer)
        add_thread(@read_thread)
      end

      def off
        LOGGER.debug(PROC) { "#off" }
        close_threads
      end

      # This should be implemented in a sub class of Interface
      def offline?
        if @stream.instance_of?(Interface::File)
          LOGGER.warn(PROC) { "IO stream is file => Bus Offline!" }
          changed
          notify_observers(Constants::Events::BUS_OFFLINE, @stream.class)
          return true
        elsif @stream.instance_of?(Interface::UART)
          LOGGER.warn(PROC) { "IO stream is tty => Bus Online!" }
          changed
          notify_observers(Constants::Events::BUS_ONLINE, @stream.class)
          return false
        else
          raise StandardError, 'no status!'
        end
      end

      private

      def parse_path(path, options)
        LOGGER.debug(PROC) { "#parse_path(#{path}, #{options})" }
        path = DEFAULT_PATH if path.nil?
        path = ::File.expand_path(path)
        file_type_handler = evaluate_stream_type(path)
        LOGGER.debug(PROC) { "File handler: #{file_type_handler}" }
        file_type_handler.new(path, options)
      end

      def evaluate_stream_type(path)
        LOGGER.debug(PROC) { "Evaluating file type of: #{path}" }
        file_type = ::File.ftype(path)
        LOGGER.debug(PROC) { "#{path} of type: #{file_type}" }
        case file_type
        when FILE_TYPE[:tty]
          LOGGER.debug(PROC) { "#{file_type} handled by: #{FILE_TYPE_HANDLERS[:tty]}" }
          FILE_TYPE_HANDLERS[:tty]
        when FILE_TYPE[:file]
          LOGGER.debug(PROC) { "#{file_type} handled by: #{FILE_TYPE_HANDLERS[:file]}" }
          FILE_TYPE_HANDLERS[:file]
        when FILE_TYPE[:fifo]
          LOGGER.debug(PROC) { "#{file_type} handled by: #{FILE_TYPE_HANDLERS[:file]}" }
          FILE_TYPE_HANDLERS[:file]
        else
          raise IOError, "Unrecognised file type: #{::File.ftype(path)}"
        end
      end

      # ------------------------------ THREADS ------------------------------ #

      def thread_populate_input_buffer(stream, input_buffer)
        LOGGER.debug(PROC) { "#thread_populate_input_buffer" }
        Thread.new do
          thread_name = 'Interface (Input Buffer)'
          tn = thread_name

          Thread.current[:name] = tn

          begin
            delay_defaults
            read_byte = nil
            parsed_byte = nil
            offline_file_count = 1

            # LOGGER.debug "Stream / Position: #{stream.pos}"

            loop do
              begin
                read_byte = nil
                parsed_byte = nil
                # readpartial will block until 1 byte is avaialble. This will
                # cause the thread to sleep

                read_byte = stream.readpartial(1)
                delay if @stream.instance_of?(Interface::File)

                # when using ARGF to concatonate multiple log files
                # readpartial will return an empty string to denote the end
                # of one file, only rasing EOF on last file
                raise EncodingError if read_byte.nil?

                parsed_byte = Byte.new(:encoded, read_byte)
                byte_basic = ByteBasic.new(read_byte)

                # NOTE this is intesresting.. this event isn't to do with the
                # primary processing..it's only for logging..
                # i could technically have a state of InputBuffer being:
                #   1. PendingData
                #   2. NoData
                changed
                notify_observers(Constants::Events::BYTE_RECEIVED, read_byte: read_byte, parsed_byte: parsed_byte, byte_basic: byte_basic)

                input_buffer.push(byte_basic)
              rescue EncodingError => e
                if stream.class == FILE_TYPE_HANDLERS[:file]
                  LOGGER.warn(tn) { "ARGF EOF. Files read: #{offline_file_count}." }
                  offline_file_count += 1
                elsif stream.class == FILE_TYPE_HANDLERS[:tty]
                  LOGGER.error(tn) { "#readpartial returned nil. Stream type: #{}." }
                end
                # LOGGER.error(")
                # sleep 2
                # e.backtrace.each { |l| LOGGER.error l }
                # LOGGER.error("read_byte: #{read_byte}")
                # LOGGER.error("parsed_byte: #{parsed_byte}")
                # binding.pry
              end
            end
          rescue EOFError
            LOGGER.warn(PROC) { "#{tn}: Stream reached EOF!" }
          rescue StandardError => e
            LOGGER.error(PROC) { "#{tn}: #{e}" }
            e.backtrace.each { |line| LOGGER.error(PROC) { line } }
          end
          LOGGER.warn(PROC) { "#{tn} thread is ending." }
        end
      end
    end
  end
end
