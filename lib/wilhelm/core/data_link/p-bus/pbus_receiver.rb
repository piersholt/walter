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
    LOGGER.debug(name) { "#{self.class}#off" }
    close_threads
  end

  def on
    LOGGER.debug(name) { "#{self.class}#on" }
    begin
      @read_thread = thread_read_buffer(@input_buffer)
      add_thread(@read_thread)
    rescue StandardError => e
      LOGGER.error(e)
      e.backtrace.each { |l| LOGGER.error(l) }
      raise e
    end
    true
  end

  def success(new_frame)
    return nil if new_frame[0..2].map(&:to_i) == [0x40, 0x00, 0x00]
    LOGGER.info(name) { new_frame }
  end

  def thread_read_buffer(buffer)
    LOGGER.debug(name) { 'New Thread: P-BUS Frame Synchronisation.' }
    Thread.new do
      Thread.current[:name] = THREAD_NAME
      # LOGGER.debug(name) { 'Entering byte shift loop.' }
      shift_count = 1
      loop do
        LOGGER.debug(name) { "##{shift_count}. Begin." }
        begin
          # LOGGER.info(name) { "Byte Buffer size: #{buffer.size}." }
          # LOGGER.info(name) { "Byte Buffer size: #{buffer}." }
          # shift_count
          # new_frame = Array.new(4)
          new_frame = buffer.shift(4)
          LOGGER.debug(name) { new_frame }
          # LOGGER.debug(name) { "#{SYNC_VALIDATION} Validating new frame." }
          checksum = new_frame[0..-2].reduce(0) { |x,y| x^=y.d }
          result = checksum == new_frame[-1].d
          LOGGER.debug(name) { "#{checksum} == #{new_frame[-1].d} => #{result}" }
          unless result
            LOGGER.warn(name) { "#{new_frame[0..-2]},#{new_frame[-1..-1]}" }
            raise ChecksumError
          end
          success(new_frame)
        rescue ChecksumError => e
          LOGGER.warn(name) { e }
          # e.backtrace.each { |l| LOGGER.error(l) }
          clean_up(buffer, new_frame)
        rescue StandardError => e
          LOGGER.error(e)
          e.backtrace.each { |l| LOGGER.error(l) }
          clean_up(buffer, new_frame)
        end
        LOGGER.debug(name) { "##{shift_count}. End." }
        shift_count += 1
      end
    end
  end

  def clean_up(buffer, new_frame)
    LOGGER.debug(name) { "#clean_up" }

    # LOGGER.debug(SYNC_ERROR) { "Publishing event: #{Constants::Events::FRAME_FAILED}" }
    # changed
    # notify_observers(Constants::Events::FRAME_FAILED, frame: new_frame)

    LOGGER.debug(name) { "Shifting one byte." }

    byte_to_discard = new_frame[0]
    LOGGER.debug(name) { "Discard: #{byte_to_discard}." }

    bytes_to_unshift = new_frame[1..-1]
    bytes_to_unshift = Bytes.new(bytes_to_unshift)
    LOGGER.debug(name) { "Unshift: #{bytes_to_unshift}." }

    LOGGER.debug(name) { "Unshifting..." }
    buffer.unshift(*bytes_to_unshift)
    LOGGER.debug(name) { "Unshifting..." }
  rescue StandardError => e
    LOGGER.error(e)
    e.backtrace.each { |l| LOGGER.warn(l) }
  end
end
