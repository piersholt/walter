class PBusReceiver
  include Observable
  include ManageableThreads

  # name = 'PBusReceiver'.freeze
  THREAD_NAME = 'PBus'

  attr_reader :input_buffer, :frame_input_buffer, :read_thread

  def initialize(input_buffer)
    @input_buffer = input_buffer
    @frame_input_buffer = SizedQueue.new(32)
  end

  def name
    self.class.name
  end

  def off
    LogActually.datalink.debug(name) { "#{self.class}#off" }
    close_threads
  end

  def on
    LogActually.datalink.debug(name) { "#{self.class}#on" }
    begin
      @read_thread = thread_read_buffer(@input_buffer)
      add_thread(@read_thread)
    rescue StandardError => e
      LogActually.datalink.error(e)
      e.backtrace.each { |l| LogActually.datalink.error(l) }
      raise e
    end
    true
  end

  def success(new_frame)
    return nil if new_frame[0..2].map(&:to_i) == [0x40, 0x00, 0x00]
    LOGGER.info(name) { new_frame }
  end

  def thread_read_buffer(buffer)
    LogActually.datalink.debug(name) { 'New Thread: P-BUS Frame Synchronisation.' }
    Thread.new do
      Thread.current[:name] = THREAD_NAME
      # LogActually.datalink.debug(name) { 'Entering byte shift loop.' }
      shift_count = 1
      loop do
        LogActually.datalink.debug(name) { "##{shift_count}. Begin." }
        begin
          # LogActually.datalink.info(name) { "Byte Buffer size: #{buffer.size}." }
          # LogActually.datalink.info(name) { "Byte Buffer size: #{buffer}." }
          # shift_count
          # new_frame = Array.new(4)
          new_frame = buffer.shift(4)
          LOGGER.debug(name) { new_frame }
          # LogActually.datalink.debug(name) { "#{SYNC_VALIDATION} Validating new frame." }
          checksum = new_frame[0..-2].reduce(0) { |x,y| x^=y.d }
          result = checksum == new_frame[-1].d
          LOGGER.debug(name) { "#{checksum} == #{new_frame[-1].d} => #{result}" }
          unless result
            LOGGER.warn(name) { "#{new_frame[0..-2]},#{new_frame[-1..-1]}" }
            raise ChecksumError
          end
          success(new_frame)
        rescue ChecksumError => e
          LogActually.datalink.warn(name) { e }
          # e.backtrace.each { |l| LogActually.datalink.error(l) }
          clean_up(buffer, new_frame)
        rescue StandardError => e
          LogActually.datalink.error(e)
          e.backtrace.each { |l| LogActually.datalink.error(l) }
          clean_up(buffer, new_frame)
        end
        LogActually.datalink.debug(name) { "##{shift_count}. End." }
        shift_count += 1
      end
    end
  end

  def clean_up(buffer, new_frame)
    LogActually.datalink.debug(name) { "#clean_up" }

    # LogActually.datalink.debug(SYNC_ERROR) { "Publishing event: #{Event::FRAME_FAILED}" }
    # changed
    # notify_observers(Event::FRAME_FAILED, frame: new_frame)

    LogActually.datalink.debug(name) { "Shifting one byte." }

    byte_to_discard = new_frame[0]
    LogActually.datalink.debug(name) { "Discard: #{byte_to_discard}." }

    bytes_to_unshift = new_frame[1..-1]
    bytes_to_unshift = Bytes.new(bytes_to_unshift)
    LogActually.datalink.debug(name) { "Unshift: #{bytes_to_unshift}." }

    LogActually.datalink.debug(name) { "Unshifting..." }
    buffer.unshift(*bytes_to_unshift)
    LogActually.datalink.debug(name) { "Unshifting..." }
  rescue StandardError => e
    LogActually.datalink.error(e)
    e.backtrace.each { |l| LogActually.datalink.warn(l) }
  end
end
