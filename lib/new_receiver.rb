require 'observer'
require 'byte_stream'
require 'frame_header'

# documentation
class Receiver
  include Observable

  def initialize(input_buffer)
    @input_buffer = input_buffer
    # @log_frames = File.new("#{Time.now.strftime'%F'}.log",  'a')
    @threads = ThreadGroup.new
  end

  def off
    LOGGER.debug "#{self.class}#off"
    close_threads
  end

  def on
    LOGGER.debug("#{self.class}#on")
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

  def

  def thread_read_buffer(buffer)
    Thread.new do
      Thread.current[:name] = 'Receiver'
      begin
        LOGGER.debug("Receiver FRAME thread starting...")
        loop do
          new_frame = Frame.new
          frame_bytes = []

          # ************************************************************************* #
          #                              FRAME HEADER
          # ************************************************************************* #

          LOGGER.debug("Header / Shifting #{Frame::HEADER_LENGTH} bytes. Buffer: #{buffer.size}")
          read_header = buffer.shift(Frame::HEADER_LENGTH)
          LOGGER.debug("Header / #{read_header}")

          frame_header = FrameHeader.new(read_header) rescue ArgumentError
          new_frame.set_header(frame_header)

          # Validate that length value of header is valid
          frame_length_value = new_frame.tail_length
          LOGGER.debug("Header / Tail Length: #{frame_length_value}")
          LOGGER.debug("Tail length is insufficient!") if frame_length_value < 3

          # ************************************************************************* #
          #                              FRAME TAIL
          # ************************************************************************* #

          LOGGER.debug("Tail / Shifting #{frame_length_value} bytes (of #{buffer.size})")
          begin
            buffered_tail = buffer.shift(frame_length_value)
          rescue StandardError
            buffered_tail = 3.times.map {|_| Byte.new(:decimal, 0) }
          end
          new_frame.tail=(buffered_tail)
          # LOGGER.debug "Tail / #{new_frame.tail_s}"

          frame_tail = FrameTail.new(buffered_tail) rescue ArgumentError
          new_frame.set_tail(frame_tail)

          # ************************************************************************* #
          #                              BUILD FRAME
          # ************************************************************************* #

          frame_bytes = read_header + buffered_tail
          # LOGGER.fatal(frame_bytes)

          # VALIDATE FRAME
          # Calculate checksum (excluding/setting last byte to 0x00)
          checksum = frame_bytes[0..-2].reduce(0) do |c,d|
            c^= d.to_d
          end

          # LOGGER.warn("checksum valid?: #{new_frame.valid?}")

          # LOGGER.debug "Frame: #{frame_bytes[-1]} / Checksum: #{checksum}"

          LOGGER.warn("Frame length is insufficient! Discarding frame.") if new_frame.size < 5

          if frame_bytes[-1].to_d == checksum && new_frame.size >= 5
            LOGGER.debug 'Frame / Checksum matches!'
            changed
            notify_observers(Event::FRAME_VALIDATED, frame: new_frame)

            LOGGER.debug "Frame / #{new_frame}"
          else
            LOGGER.debug 'Checksum failed!'
            changed
            notify_observers(Event::FRAME_FAILED, frame: new_frame)

            LOGGER.debug "Frame / #{new_frame}"

            LOGGER.debug "Dropping byte: #{frame_bytes[0]}"
            buffer.unshift(*frame_bytes[1..-1])
          end
        end
        # ^ loop
      rescue Exception => e
        LOGGER.error("Shift thread exception..! #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
      LOGGER.error("#{self.class} thread is finished..!")
    end # thread_w
  end
end
