
require 'data_link/frame/frame'

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
    LogActually.datalink.debug(PROG_NAME) { 'New Thread: Frame Synchronisation.' }
    Thread.new do
      Thread.current[:name] = THREAD_NAME
      begin
        LogActually.datalink.debug(PROG_NAME) { 'Entering byte shift loop.' }
        shift_count = 1
        # binding.pry
        loop do
          LogActually.datalink.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. Begin." }
          shift_count
          new_frame = Frame.new

          begin
            # ************************************************************************* #
            #                              FRAME HEADER
            # ************************************************************************* #

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC} Byte Buffer size: #{buffer.size}." }

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_HEADER} Trying to shift #{Frame::HEADER_LENGTH} bytes." }
            header_bytes = buffer.shift(Frame::HEADER_LENGTH)
            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_HEADER} Shifted bytes: #{header_bytes}" }

            # LogActually.datalink.debug(SYNC_HEADER) { "Setting new frame header." }
            new_frame.set_header(header_bytes)
            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_HEADER} New frame header set: #{new_frame.header}" }

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_HEADER} Getting remaining frame bytes from header." }
            remaining_frame_bytes = new_frame.header.tail_length
            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_HEADER} Remaining frame bytes: #{remaining_frame_bytes}" }

            # ************************************************************************* #
            #                              FRAME TAIL
            # ************************************************************************* #

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC} Input Buffer: #{buffer.size}." }

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_TAIL} Shifting #{remaining_frame_bytes} bytes." }
            tail_bytes = buffer.shift(remaining_frame_bytes)
            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_TAIL} Shifted bytes: #{tail_bytes}" }

            # LogActually.datalink.debug(SYNC_TAIL) { "Setting new frame tail." }
            new_frame.set_tail(tail_bytes)
            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_TAIL} New frame tail set: #{new_frame.tail}" }

            # ************************************************************************* #
            #                             FRAME CHECKSUM
            # ************************************************************************* #

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC_VALIDATION} Validating new frame." }
            raise ChecksumError unless new_frame.valid?

            # ************************************************************************* #
            #                                FINISH
            # ************************************************************************* #

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC} Valid! #{new_frame}" }

            LogActually.datalink.debug(PROG_NAME) { "#{SYNC} Publishing event: #{Event::FRAME_RECEIVED}" }
            changed
            notify_observers(Event::FRAME_RECEIVED, frame: new_frame)

            LogActually.datalink.unknown(PROG_NAME) { "frame_input_buffer.push(#{new_frame})" }
            frame_input_buffer.push(new_frame)
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            LogActually.datalink.debug(SYNC_ERROR) { e }
            # e.backtrace.each { |l| LogActually.datalink.error(l) }
            clean_up(buffer, new_frame)
          rescue StandardError => e
            LogActually.datalink.error(e)
            e.backtrace.each { |l| LogActually.datalink.error(l) }
            clean_up(buffer, new_frame)
          end
          LogActually.datalink.debug(PROG_NAME) { "#{SYNC} ##{shift_count}. End." }
          shift_count += 1
        end
      rescue Exception => e
        LogActually.datalink.error(PROG_NAME) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
        e.backtrace.each { |l| LogActually.datalink.error(l) }
        binding.pry
      end
      LogActually.datalink.warn(PROG_NAME) { "#{self.class} thread is finished..!" }
    end # thread_w
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
