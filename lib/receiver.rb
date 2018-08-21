require 'observer'

# documentation
class Receiver
  include Observable

  def initialize(channel)
    @channel = channel
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
      read_thread = thread_read_buffer(@channel.input_buffer)
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
    Thread.new do
      Thread.current[:name] = 'Receiver' 
      begin
        LOGGER.debug("Receiver FRAME thread starting...")
        loop do
          # LOGGER.debug 'Thread / Framer acquiring lock!'
          current_frame = Frame.new

          LOGGER.debug("#{self.class} / Shifting #{Frame::HEADER_LENGTH} bytes (of #{buffer.size})")
          buffered_header = buffer.shift(Frame::HEADER_LENGTH)
          current_frame.header=(buffered_header)
          LOGGER.debug("Header / #{current_frame.header_s}")


          frame_length_value = current_frame.tail_length
          LOGGER.debug("Header / Tail Length: #{frame_length_value}")
          LOGGER.debug("Tail length is insufficient!") if frame_length_value < 3

          LOGGER.debug("Tail / Shifting #{frame_length_value} bytes (of #{buffer.size})")
          begin
            buffered_tail = buffer.shift(frame_length_value)
          rescue StandardError
            buffered_tail = 3.times.map {|_| Byte.new(:decimal, 0) }
          end
          current_frame.tail=(buffered_tail)
          # LOGGER.debug "Tail / #{current_frame.tail_s}"

          # CONSTRUCT FRAME
          # LOGGER.debug "Frame (Pending) / #{current_frame}"
          frame_complete = buffered_header + buffered_tail

          # VALIDATE FRAME
          # Calculate checksum (excluding/setting last byte to 0x00)
          checksum = frame_complete[0..-2].reduce(0) do |c,d|
            c^= d.to_d
          end

          # LOGGER.debug "Frame: #{frame_complete[-1]} / Checksum: #{checksum}"

          LOGGER.warn("Frame length is insufficient! Discarding frame.") if current_frame.size < 5

          if frame_complete[-1].to_d == checksum && current_frame.size >= 5
            LOGGER.debug 'Frame / Checksum matches!'
            changed
            notify_observers(Event::FRAME_VALIDATED, frame: current_frame)

            LOGGER.debug "Frame / #{current_frame}"
          else
            LOGGER.debug 'Checksum failed!'
            changed
            notify_observers(Event::FRAME_FAILED, frame: current_frame)

            LOGGER.debug "Frame / #{current_frame}"

            LOGGER.debug "Dropping byte: #{frame_complete[0]}"
            buffer.unshift(*frame_complete[1..-1])
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
