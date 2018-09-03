# require 'thread'
require 'observer'

require 'channel/device'
require 'channel/file'
require 'channel/byte_buffer'

class Channel
  include Observable

  FILE_TYPE = { tty: 'characterSpecial', file: 'file' }.freeze
  FILE_TYPE_HANDLERS = { tty: Channel::Device, file: Channel::File }.freeze
  DEFAULT_PATH = '/dev/cu.SLAB_USBtoUART'.freeze
  NO_OPTIONS = {}.freeze

  attr_reader :input_buffer

  def initialize(path, options = NO_OPTIONS)
    path = DEFAULT_PATH if path.nil?
    path = ::File.expand_path(path)
    file_type_handler = evaluate_stream_type(path)
    LOGGER.debug("File handler: #{file_type_handler}")
    @stream = file_type_handler.new(path, options)

    @input_buffer = ByteBuffer.new

    @threads = ThreadGroup.new
  end

  def on
    offline?
    @threads.add(thread_read)
  end

  def off
    LOGGER.debug "#{self.class}#off"
    close_threads
  end
  # NOTE this is a much better example of state, in which channel is either
  # online or offline- in saying that.. it's not implemented well, at, all.
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

  def evaluate_stream_type(path)
    LOGGER.debug("Evaluating file type of: #{path}")
    file_type = ::File.ftype(path)
    LOGGER.debug("#{path} of type: #{file_type}")
    case file_type
    when FILE_TYPE[:tty]
      LOGGER.debug("#{file_type} handled by: #{FILE_TYPE_HANDLERS[:tty]}")
      FILE_TYPE_HANDLERS[:tty]
    when FILE_TYPE[:file]
      LOGGER.debug("#{file_type} handled by: #{FILE_TYPE_HANDLERS[:file]}")
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
    LOGGER.debug "#{self.class}#close_threads"
    threads = @threads.list
    threads.each_with_index do |t, i|
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
      # LOGGER.debug "result = #{t.exit}"
      t.exit
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
    end
  end

  def thread_read
    LOGGER.debug("#{self.class}#thread_read")
    Thread.new do
      Thread.current[:name] = 'Channel'
      begin
        LOGGER.debug("Channel READ thread starting...")
        # binding.pry
        LOGGER.debug "Stream / Position: #{@stream.pos}"

        read_byte = nil
        parsed_byte = nil
        offline_file_count = 1

        loop do
          begin
            read_byte = nil
            parsed_byte = nil
            # readpartial will block until 1 byte is avaialble. This will
            # cause the thread to sleep
            read_byte = @stream.readpartial(1)

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
            notify_observers(Event::BYTE_RECEIVED, read_byte: read_byte, parsed_byte: parsed_byte, pos: @stream.pos)

            @input_buffer.push(parsed_byte)
          rescue EncodingError => e
            if @stream.class == FILE_TYPE_HANDLERS[:file]
              LOGGER.warn("ARGF EOF. Files read: #{offline_file_count}.")
              offline_file_count += 1
            elsif @stream.class == FILE_TYPE_HANDLERS[:tty]
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
        LOGGER.warn('Stream reached EOF!')
      rescue Exception => e
        LOGGER.error("Read thread exception..! #{e}")
        e.backtrace.each { |line| LOGGER.error line }
      end
      LOGGER.error("#{self.class} thread is finished..!")
    end
  end

  # TODO Kill child threads
  # Should be notify method and App broadcasts it
  def kill
  end

end
