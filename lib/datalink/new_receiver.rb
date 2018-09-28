require 'observer'
require 'datalink/frame/new_frame'

class NewReceiver
  PROG_NAME = 'Receiver'.freeze
  THREAD_NAME = 'Receiver'

  SYNC = 'Sync /'
  SYNC_HEADER = 'Header /'
  SYNC_TAIL = 'Tail /'
  SYNC_VALIDATION = 'Validate /'
  SYNC_ERROR = 'Error /'
  SYNC_SHIFT = 'Unshift! /'

  include Observable

  attr_reader :threads

  def initialize(input_buffer)
    @input_buffer = input_buffer
    @threads = ThreadGroup.new
  end

  def off
    LOGGER.debug(PROG_NAME) { "#{self.class}#off" }
    close_threads
  end

  def on
    LOGGER.debug(PROG_NAME) { "#{self.class}#on" }
    begin
      read_thread = thread_read_buffer(@input_buffer)
      @threads.add(read_thread)
    rescue StandardError => e
      LOGGER.error(e)
      e.backtrace.each { |l| LOGGER.error(l) }
      raise e
    end
    true
  end

  private

  # ------------------------------ THREADS ------------------------------ #

  def close_threads
    LOGGER.debug "#{self.class}#close_threads"
    LOGGER.info(PROG_NAME) { "Closing threads." }
    LOGGER.info(PROG_NAME) { "#{@threads}" }
    threads = @threads.list
    threads.each_with_index do |t, i|
      LOGGER.info(PROG_NAME) { "Thread #{i+1}: #{t[:name]} / Currently: #{t.status}" }
      # LOGGER.debug "result = #{t.exit}"
      t.exit.join
      LOGGER.info(PROG_NAME) { "Thread #{i+1}: #{t[:name]} / Stopped? #{t.stop?}" }
    end
  end

  def thread_read_buffer(buffer)
    LOGGER.debug(PROG_NAME) { 'New Thread: Frame Synchronisation.' }
    Thread.new do
      Thread.current[:name] = THREAD_NAME
      begin
        LOGGER.debug(PROG_NAME) { 'Entering byte shift loop.' }
        shift_count = 1
        # binding.pry
        loop do
          LOGGER.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. Begin." }
          shift_count
          new_frame = NewFrame.new

          begin
            # ************************************************************************* #
            #                              FRAME HEADER
            # ************************************************************************* #

            LOGGER.debug(PROG_NAME) { "#{SYNC} Byte Buffer size: #{buffer.size}." }

            LOGGER.debug(PROG_NAME) { "#{SYNC_HEADER} Trying to shift #{NewFrame::HEADER_LENGTH} bytes." }
            header_bytes = buffer.shift(NewFrame::HEADER_LENGTH)
            LOGGER.debug(PROG_NAME) { "#{SYNC_HEADER} Shifted bytes: #{header_bytes}" }

            # LOGGER.debug(SYNC_HEADER) { "Setting new frame header." }
            new_frame.set_header(header_bytes)
            LOGGER.debug(PROG_NAME) { "#{SYNC_HEADER} New frame header set: #{new_frame.header}" }

            LOGGER.debug(PROG_NAME) { "#{SYNC_HEADER} Getting remaining frame bytes from header." }
            remaining_frame_bytes = new_frame.header.tail_length
            LOGGER.debug(PROG_NAME) { "#{SYNC_HEADER} Remaining frame bytes: #{remaining_frame_bytes}" }

            # ************************************************************************* #
            #                              FRAME TAIL
            # ************************************************************************* #

            LOGGER.debug(PROG_NAME) { "#{SYNC} Input Buffer: #{buffer.size}." }

            LOGGER.debug(PROG_NAME) { "#{SYNC_TAIL} Shifting #{remaining_frame_bytes} bytes." }
            tail_bytes = buffer.shift(remaining_frame_bytes)
            LOGGER.debug(PROG_NAME) { "#{SYNC_TAIL} Shifted bytes: #{tail_bytes}" }

            # LOGGER.debug(SYNC_TAIL) { "Setting new frame tail." }
            new_frame.set_tail(tail_bytes)
            LOGGER.debug(PROG_NAME) { "#{SYNC_TAIL} New frame tail set: #{new_frame.tail}" }

            # ************************************************************************* #
            #                             FRAME CHECKSUM
            # ************************************************************************* #

            LOGGER.debug(PROG_NAME) { "#{SYNC_VALIDATION} Validating new frame." }
            raise ChecksumError unless new_frame.valid?

            # ************************************************************************* #
            #                                FINISH
            # ************************************************************************* #

            LOGGER.debug(PROG_NAME) { "#{SYNC} Valid! #{new_frame}" }

            LOGGER.debug(PROG_NAME) { "#{SYNC} Publishing event: #{Event::FRAME_RECEIVED}" }
            changed
            notify_observers(Event::FRAME_RECEIVED, frame: new_frame)
          rescue HeaderValidationError, HeaderInvalidError, TailValidationError, ChecksumError => e
            LOGGER.debug(SYNC_ERROR) { e }
            # e.backtrace.each { |l| LOGGER.error(l) }
            clean_up(buffer, new_frame)
          rescue StandardError => e
            LOGGER.error(e)
            e.backtrace.each { |l| LOGGER.error(l) }
            clean_up(buffer, new_frame)
          end
          LOGGER.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. End." }
          shift_count += 1
        end
      rescue Exception => e
        LOGGER.error(PROG_NAME) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
      LOGGER.warn(PROG_NAME) { "#{self.class} thread is finished..!" }
    end # thread_w
  end

  def clean_up(buffer, new_frame)
    LOGGER.debug(PROG_NAME) { "#{SYNC_ERROR} #clean_up" }

    # LOGGER.debug(SYNC_ERROR) { "Publishing event: #{Event::FRAME_FAILED}" }
    # changed
    # notify_observers(Event::FRAME_FAILED, frame: new_frame)

    LOGGER.debug(PROG_NAME) { "#{SYNC_SHIFT} Shifting one byte." }

    byte_to_discard = new_frame[0]
    LOGGER.warn(PROG_NAME) { "#{SYNC_SHIFT} Discard: #{byte_to_discard}." }

    bytes_to_unshift = new_frame[1..-1]
    bytes_to_unshift = Bytes.new(bytes_to_unshift)
    LOGGER.debug(PROG_NAME) { "#{SYNC_SHIFT} Unshift: #{bytes_to_unshift}." }

    LOGGER.debug(PROG_NAME) { "#{SYNC_SHIFT} Unshifting..." }
    buffer.unshift(*bytes_to_unshift)
  end
end
