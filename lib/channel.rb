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

  attr_reader :input_buffer, :output_buffer, :threads, :read_thread, :test_thread

  # The interface should protect the channel from the implementation.
  # i shouldn't be forwarding methods.. that's what bit me with rubyserial
  # i was tried to the API of the library.. and not protected for it
  # it's responsible for a consistent APi. how #read is implemented

  def initialize(path, options = NO_OPTIONS)
    @stream = parse_path(path, options)

    @input_buffer = ByteBuffer.new
    @output_buffer = Queue.new

    @threads = ThreadGroup.new
  end

  def on
    offline?

    @read_thread = thread_populate_input_buffer(@stream, @input_buffer)
    @threads.add(@read_thread)
    @test_thread = thread_test
    @threads.add(@test_thread)
    @thread_activity_monitor = thread_activity_monitor
    @threads.add(@thread_activity_monitor)
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

  def parse_path(path, options)
    LOGGER.debug("#{self.class}#parse_path(#{path}, #{options})")
    path = DEFAULT_PATH if path.nil?
    path = ::File.expand_path(path)
    file_type_handler = evaluate_stream_type(path)
    LOGGER.debug("File handler: #{file_type_handler}")
    file_type_handler.new(path, options)
  end

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

  def idle?
    @read_thread.stop? ? true : false
  end

  def busy?
    @read_thread.stop? ? false : true
  end

  # A thread that monitors the stream.....
  # fires events: bus_idle, bus_busy, bus_active
  # probably not... use thoes to stop write... do both
  # it colud be based on.... thread_populate_input_buffer sleep timout
  def thread_activity_monitor
    Thread.new do
      start_time = nil
      min_idle_time_reached = nil

      min_idle_duration = 3

      # While bus is idle, a transmission can begin at any time
      # A byte takes 11 baud times, thus the intervals between bytes
      # are a minimum of 1/6982.. sleeping for a shorter duration is likely
      # to be ineffective?
      idle_interval = 1/6982
      busy_interval = 1/(9600/11)

      # loop do
      #   puts busy?
      #   sleep(busy_interval)
      # end

      loop do
        until idle? do
          # puts 'busy!'
          sleep(busy_interval)
        end

        LOGGER.fatal('BUS idle!')

        start_time = Time.now

        until busy? || min_idle_time_reached do
          # puts 'waiting for busy or min_idle!'
          elapsed_time = Time.now - start_time
          min_idle_time_reached = elapsed_time > min_idle_duration ? true : false
          sleep(idle_interval)
        end

        LOGGER.fatal('BUS available!') if min_idle_time_reached
        while idle? do
          # puts 'idle! waiting until busy'
          sleep(idle_interval)
        end

        min_idle_time_reached = false

        LOGGER.fatal('BUS busy!')

        # break

        # puts 'starting the loop over again....'
      end

      puts 'game over man, game over!'
    end
  end

  def thread_test
    LOGGER.debug("#{self.class}#thread_test")
    Thread.new do
      Thread.current[:name] = 'Channel (Test)'

      LOGGER.error("Channel") { "Thread: #{Thread.current[:name]} / Sleeping..." }
      sleep(5)
      LOGGER.error("Channel") { "Thread: #{Thread.current[:name]} / Alive!" }
      # Thread.join
      # Thread.stop
      LOGGER.error("Channel") { "Thread: #{Thread.current[:name]} / I shoudn't be here?" }
    end
  end

  def thread_populate_input_buffer(stream, input_buffer)
    LOGGER.debug("#{self.class}#thread_populate_input_buffer")
    Thread.new do
      Thread.current[:name] = 'Channel (Read)'

      begin
        LOGGER.debug("Channel READ thread starting...")
        # binding.pry
        LOGGER.debug "Stream / Position: #{stream.pos}"

        read_byte = nil
        parsed_byte = nil
        offline_file_count = 1

        loop do
          begin
            read_byte = nil
            parsed_byte = nil
            # readpartial will block until 1 byte is avaialble. This will
            # cause the thread to sleep

            read_byte = stream.readpartial(1)
            sleep(0.5)

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
              LOGGER.warn("ARGF EOF. Files read: #{offline_file_count}.")
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
        LOGGER.warn('Stream reached EOF!')
      rescue Exception => e
        LOGGER.error("Read thread exception..! #{e}")
        e.backtrace.each { |line| LOGGER.error line }
      end
      LOGGER.warn("#{self.class} thread is finished..!")
    end
  end

  # TODO Kill child threads
  # Should be notify method and App broadcasts it
  def kill
  end

end
