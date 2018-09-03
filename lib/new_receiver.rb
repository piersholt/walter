require 'observer'
require 'new_frame'

class NewReceiver
  PROG_NAME = 'Receiver'.freeze
  PROCESS_SYNC = 'Receiver / Sync'
  PROCESS_SYNC_HEADER = 'Receiver / Header'
  PROCESS_SYNC_TAIL = 'Receiver / Tail'
  PROCESS_SYNC_VALIDATION = 'Receiver / Validate'
  PROCESS_SYNC_ERROR = 'Receiver / Error'
  PROCESS_SYNC_SHIFT = 'Receiver / Unshift!'

  include Observable

  def initialize(input_buffer)
    @input_buffer = input_buffer
    @threads = ThreadGroup.new
  end

  def off
    LOGGER.debug "#{self.class}#off"
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
    threads = @threads.list
    threads.each_with_index do |t, i|
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
      # LOGGER.debug "result = #{t.exit}"
      t.exit
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
    end
  end

  def thread_read_buffer(buffer)
    LOGGER.debug(PROG_NAME) { 'New Thread: Frame Synchronisation.' }
    Thread.new do
      Thread.current[:name] = PROG_NAME
      begin
        LOGGER.debug(PROG_NAME) { 'Entering byte shift loop.' }
        shift_count = 1
        # binding.pry
        loop do
          LOGGER.debug(PROCESS_SYNC) { "##{shift_count}. Begin." }
          shift_count
          new_frame = NewFrame.new

          begin
            # ************************************************************************* #
            #                              FRAME HEADER
            # ************************************************************************* #

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Input Buffer: #{buffer.size}." }

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Trying to shift #{Frame::HEADER_LENGTH} bytes." }
            header_bytes = buffer.shift(Frame::HEADER_LENGTH)
            LOGGER.debug(PROCESS_SYNC_HEADER) { "Shifted bytes: #{header_bytes}" }

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Setting new frame header." }
            new_frame.set_header(header_bytes)
            LOGGER.debug(PROCESS_SYNC_HEADER) { "New frame header set: #{new_frame.header}" }

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Getting remaining frame bytes from header." }
            remaining_frame_bytes = new_frame.header.tail_length
            LOGGER.debug(PROCESS_SYNC_HEADER) { "Remaining frame bytes: #{remaining_frame_bytes}" }

            # ************************************************************************* #
            #                              FRAME TAIL
            # ************************************************************************* #

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Input Buffer: #{buffer.size}." }

            LOGGER.debug(PROCESS_SYNC_TAIL) { "Shifting #{remaining_frame_bytes} bytes." }
            tail_bytes = buffer.shift(remaining_frame_bytes)
            LOGGER.debug(PROCESS_SYNC_TAIL) { "Shifted bytes: #{tail_bytes}" }

            LOGGER.debug(PROCESS_SYNC_HEADER) { "Setting new frame tail." }
            new_frame.set_tail(tail_bytes)
            LOGGER.debug(PROCESS_SYNC_HEADER) { "New frame tail set: #{new_frame.tail}" }

            # ************************************************************************* #
            #                             FRAME CHECKSUM
            # ************************************************************************* #

            LOGGER.debug(PROCESS_SYNC_VALIDATION) { "Validating new frame." }
            raise ChecksumError unless new_frame.valid?

            # ************************************************************************* #
            #                                FINISH
            # ************************************************************************* #

            LOGGER.debug(PROCESS_SYNC) { "Valid! #{new_frame}" }

            LOGGER.debug(PROCESS_SYNC) { "Publishing event: #{Event::FRAME_VALIDATED}" }
            changed
            notify_observers(Event::FRAME_VALIDATED, frame: new_frame)
          rescue HeaderValidationError, HeaderInvalidError, TailValidationError, ChecksumError => e
            LOGGER.error(e)
            e.backtrace.each { |l| LOGGER.error(l) }
            clean_up(buffer, new_frame)
          rescue StandardError, TailError, ChecksumError => e
            LOGGER.error(e)
            e.backtrace.each { |l| LOGGER.error(l) }
            clean_up(buffer, new_frame)
          end
          LOGGER.debug(PROCESS_SYNC) { "##{shift_count}. End." }
          shift_count += 1
        end
      rescue Exception => e
        LOGGER.error(PROCESS_SYNC_ERROR) { "Shift thread exception..! #{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
      LOGGER.warn(PROCESS_SYNC_ERROR) { "#{self.class} thread is finished..!" }
    end # thread_w
  end

  def clean_up(buffer, frame)
    LOGGER.debug(PROCESS_SYNC_ERROR) { "Cleaning up..." }

    LOGGER.debug(PROCESS_SYNC_ERROR) { "Publishing event: #{Event::FRAME_FAILED}" }
    changed
    notify_observers(Event::FRAME_FAILED, frame: frame)

    LOGGER.warn(PROCESS_SYNC_SHIFT) { "Bit Shift!" }

    byte_to_discard = new_frame[0]
    LOGGER.warn(PROCESS_SYNC_SHIFT) { "Discard: #{byte_to_discard}." }

    bytes_to_unshift = new_frame[1..-1]
    LOGGER.warn(PROCESS_SYNC_SHIFT) { "Unshift: #{bytes_to_unshift}" }

    LOGGER.warn(PROCESS_SYNC_SHIFT) { "Unshifting..." }
    result = buffer.unshift(*bytes_to_unshift)
    LOGGER.debug(PROCESS_SYNC_SHIFT) { "Unshifting result: #{result}" }
  end
end
