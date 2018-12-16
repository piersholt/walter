class Receiver
  PROG_NAME = 'Receiver'.freeze
  THREAD_NAME = 'Receiver'

  SYNC = 'Sync /'
  SYNC_HEADER = 'Header /'
  SYNC_TAIL = 'Tail /'
  SYNC_VALIDATION = 'Validate /'
  SYNC_ERROR = 'Error /'
  SYNC_SHIFT = 'Unshift! /'

  include Observable
  include ManageableThreads

  attr_reader :input_buffer, :frame_input_buffer, :read_thread

  def initialize(input_buffer)
    @input_buffer = input_buffer
    @frame_input_buffer = SizedQueue.new(32)
  end

  def off
    LogActually.datalink.debug(PROG_NAME) { "#{self.class}#off" }
    close_threads
  end

  def on
    LogActually.datalink.debug(PROG_NAME) { "#{self.class}#on" }
    begin
      @read_thread = thread_read_buffer(@input_buffer, @frame_input_buffer)
      add_thread(@read_thread)
    rescue StandardError => e
      LogActually.datalink.error(e)
      e.backtrace.each { |l| LogActually.datalink.error(l) }
      raise e
    end
    true
  end

  private

  # ------------------------------ THREADS ------------------------------ #

  def thread_read_buffer(buffer, frame_input_buffer)
    Thread.new do
      LogActually.datalink.debug(PROG_NAME) { 'New Thread: Frame Synchronisation.' }
      Thread.current[:name] = THREAD_NAME
      synchronisation(buffer)
      LogActually.datalink.warn(PROG_NAME) { "#{self.class} thread is finished..!" }
    end
  end

  def synchronise_frame(buffer)
    synchronisation = FrameSynchronisation.new(buffer)
    synchronisation.run
  rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
    clean_up(buffer, synchronisation.frame)
  rescue StandardError => e
    LogActually.datalink.error(e)
    e.backtrace.each { |l| LogActually.datalink.error(l) }
    clean_up(buffer, synchronisation.frame)
  end

  def synchronisation(buffer)
    LogActually.datalink.debug(PROG_NAME) { 'Entering byte shift loop.' }
    shift_count = 1
    # binding.pry
    loop do
      LogActually.datalink.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. Begin." }
      new_frame = synchronise_frame(buffer)

      LogActually.datalink.debug(PROG_NAME) { "#{SYNC} Publishing event: #{Event::FRAME_RECEIVED}" }
      changed
      notify_observers(Event::FRAME_RECEIVED, frame: new_frame)

      LogActually.datalink.debug(PROG_NAME) { "frame_input_buffer.push(#{new_frame})" }
      frame_input_buffer.push(new_frame)

      LogActually.datalink.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. End." }
      shift_count += 1
    end
  rescue StandardError => e
    LogActually.datalink.error(PROG_NAME) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
    e.backtrace.each { |l| LogActually.datalink.error(l) }
    binding.pry
  end

  def clean_up(buffer, new_frame)
    LogActually.datalink.debug(PROG_NAME) { "#{SYNC_ERROR} #clean_up" }

    # LogActually.datalink.debug(SYNC_ERROR) { "Publishing event: #{Event::FRAME_FAILED}" }
    # changed
    # notify_observers(Event::FRAME_FAILED, frame: new_frame)

    LogActually.datalink.debug(PROG_NAME) { "#{SYNC_SHIFT} Shifting one byte." }

    byte_to_discard = new_frame[0]
    LogActually.datalink.debug(PROG_NAME) { "#{SYNC_SHIFT} Discard: #{byte_to_discard}." }

    bytes_to_unshift = new_frame[1..-1]
    bytes_to_unshift = Bytes.new(bytes_to_unshift)
    LogActually.datalink.debug(PROG_NAME) { "#{SYNC_SHIFT} Unshift: #{bytes_to_unshift}." }

    LogActually.datalink.debug(PROG_NAME) { "#{SYNC_SHIFT} Unshifting..." }
    buffer.unshift(*bytes_to_unshift)
  end
end
