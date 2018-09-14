# require 'thread'
require 'observer'

require 'channel/device'
require 'channel/file'
require 'channel/byte_buffer'
require 'channel/output_buffer'

class Channel
  include Observable

  FILE_TYPE = { tty: 'characterSpecial', file: 'file' }.freeze
  FILE_TYPE_HANDLERS = { tty: Channel::Device, file: Channel::File }.freeze
  DEFAULT_PATH = '/dev/cu.SLAB_USBtoUART'.freeze
  NO_OPTIONS = {}.freeze

  attr_reader :input_buffer, :output_buffer, :threads, :read_thread

  # The interface should protect the channel from the implementation.
  # i shouldn't be forwarding methods.. that's what bit me with rubyserial
  # i was tried to the API of the library.. and not protected for it
  # it's responsible for a consistent APi. how #read is implemented

  def initialize(path, options = NO_OPTIONS)
    @stream = parse_path(path, options)

    @input_buffer = ByteBuffer.new
    @output_buffer = OutputBuffer.new(@stream)

    @threads = ThreadGroup.new
  end

  def on
    offline?

    @read_thread = thread_populate_input_buffer(@stream, @input_buffer)
    @threads.add(@read_thread)
  end

  def off
    LOGGER.debug('Channel') { "#off" }
    close_threads
  end
  def offline?
    if @stream.instance_of?(Channel::File)
      changed
      notify_observers(Event::BUS_OFFLINE, @stream.class)
      return true
    elsif @stream.instance_of?(Channel::Device)
      changed
      notify_observers(Event::BUS_ONLINE, @stream.class)
      return false
    else
      raise StandardError, 'no status!'
    end
  end

  private

  def parse_path(path, options)
    LOGGER.debug('Channel') { "#parse_path(#{path}, #{options})" }
    path = DEFAULT_PATH if path.nil?
    path = ::File.expand_path(path)
    file_type_handler = evaluate_stream_type(path)
    LOGGER.debug('Channel') { "File handler: #{file_type_handler}" }
    file_type_handler.new(path, options)
  end

  def evaluate_stream_type(path)
    LOGGER.debug('Channel') { "Evaluating file type of: #{path}" }
    file_type = ::File.ftype(path)
    LOGGER.debug('Channel') { "#{path} of type: #{file_type}" }
    case file_type
    when FILE_TYPE[:tty]
      LOGGER.debug('Channel') { "#{file_type} handled by: #{FILE_TYPE_HANDLERS[:tty]}" }
      FILE_TYPE_HANDLERS[:tty]
    when FILE_TYPE[:file]
      LOGGER.debug('Channel') { "#{file_type} handled by: #{FILE_TYPE_HANDLERS[:file]}" }
      FILE_TYPE_HANDLERS[:file]
    else
      raise IOError, "Unrecognised file type: #{File.ftype(path)}"
    end
  end

  # ------------------------------ THREADS ------------------------------ #
  # NOTE this is also good for states..
  # State(s):
  # 1. No threads
  # 2. Active threads
  # 3. Dormant
  # Each would have a different way of handling #exit()

  def close_threads
    LOGGER.debug('Channel') { "#{self.class}#close_threads" }
    LOGGER.info('Channel') { "Closing threads." }
    LOGGER.info("Channel") { "#{@threads}" }
    threads = @threads.list
    threads.each_with_index do |t, i|
      LOGGER.info("Channel") { "Thread #{i+1}: #{t[:name]} / Currently: #{t.status}" }
      # LOGGER.debug "result = #{t.exit}"
      t.exit.join
      LOGGER.info("Channel") { "Thread #{i+1}: #{t[:name]}  / Stopped? #{t.stop?}" }
    end
  end

  def sleep_if_offline
    sleep(5) if @stream.instance_of?(Channel::File)
  end

  def thread_populate_input_buffer(stream, input_buffer)
    LOGGER.debug('Channel') { "#thread_populate_input_buffer" }
    Thread.new do
      thread_name = 'Channel (Input Buffer)'
      tn = thread_name
      Thread.current[:name] = thread_name

      begin
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
            sleep_if_offline

            # when using ARGF to concatonate multiple log files
            # readpartial will return an empty string to denote the end
            # of one file, only rasing EOF on last file
            raise EncodingError if read_byte.nil?

            parsed_byte = Byte.new(:encoded, read_byte)

            # NOTE this is intesresting.. this event isn't to do with the
            # primary processing..it's only for logging..
            # i could technically have a state of ByteBuffer being:
            #   1. PendingData
            #   2. NoData
            changed
            notify_observers(Event::BYTE_RECEIVED, read_byte: read_byte, parsed_byte: parsed_byte, pos: stream.pos)

            input_buffer.push(parsed_byte)
          rescue EncodingError => e
            if stream.class == FILE_TYPE_HANDLERS[:file]
              LOGGER.warn('Channel') { "ARGF EOF. Files read: #{offline_file_count}." }
              offline_file_count += 1
            elsif stream.class == FILE_TYPE_HANDLERS[:tty]
              LOGGER.error("#readpartial returned nil. Stream type: #{}.")
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
        LOGGER.warn('Channel') { "#{tn}: Stream reached EOF!" }
      rescue StandardError => e
        LOGGER.error('Channel') { "#{tn}: #{e}" }
        e.backtrace.each { |line| LOGGER.error('Channel') { line } }
      end
      LOGGER.warn('Channel') { "#{tn} thread is ending." }
    end
  end
end
