require 'observer'
require 'thread'

require 'serialport'
require 'pry'

require 'byte'
require 'frame'
require 'device'
require 'message'

# @deprecated
# Framer
class Framer
  include Observable
  TTY = '/dev/cu.SLAB_USBtoUART'
  TTY_PARAMS = { "baud" => 9600, "data_bits" => 8, "stop_bits" => 1, "parity" => 2 }

  HEADER_LENGTH = 2
  HEADER_LENGTH_FIELD_INDEX = -1

  attr_reader :stream, :threads

  def initialize
    # serial_port = SerialPort.new(TTY, TTY_PARAMS)
    # serial_port.flow_control = SerialPort::HARD
    # @stream = serial_port

    @stream = ARGF

    add_observer(Device, :update)
    add_observer(Command, :update)

    @log_stream = File.new("#{Time.now.strftime'%F'}.bin",  'a')
    @log_frames = File.new("#{Time.now.strftime'%F'}.log",  'a')

    @threads = ThreadGroup.new

    @stats = { bytes_read: 0, bytes_dropped: 0, frames: 0, frames_failed: 0 }
    @queue = Queue.new
  end

  def start
    binding.pry
    LOGGER.info("Starting @ #{Time.now}")
    mutex = Mutex.new
    condvar  = ConditionVariable.new
    buffer = []

    begin
      thread_r = spawn_thread_stream_read(buffer, mutex, condvar, @stats)
      @threads.add(thread_r)
      thread_w = spawn_thread_shift(buffer, mutex, condvar, @stats)
      @threads.add(thread_w)
      thread_register = spawn_thread_register
      @threads.add(thread_register)

      LOGGER.debug "Main Thread / Entering keep alive loop..."
      loop do
        LOGGER.debug "reader: #{thread_r.status}"
        LOGGER.debug "framer: #{thread_w.status}"
        LOGGER.debug "register: #{thread_register.status}"
        sleep 5
      end
    rescue Interrupt
      LOGGER.debug 'Break signal detected.'
      LOGGER.info 'Quiting...'
      LOGGER.debug "Stats: #{@stats}"

      LOGGER.debug "Closing threads..."
      thread_r.exit
      thread_w.exit
      thread_register.exit

      # TODO: decouple register via event
      Device.close
      Command.close

      # LOGGER.debug "Notifying observers: #{count_observers}"
      # changed
      # notify_observers(nil)

      LOGGER.debug 'Closing log files...'
      @log_frames.close
      @log_stream.close
      binding.pry if LOGGER.sev_threshold == Logger::DEBUG
      return 1
    end

    LOGGER.warn 'Framer#start returning!'
    1
  end

  private

  def spawn_thread_register
    Thread.new do
      begin
        # sleep 5
        # binding.pry
        add_observer(Device, :update)
        add_observer(Command, :update)

        loop do
          new_frame = @queue.shift
          message = Message.from_frame(new_frame)
          LOGGER.info(message.to_s)

          changed
          notify_observers(message)
        end
      rescue Exception => e
        LOGGER.error("Register thread exception..! #{e}")
        e.backtrace.each { |t| LOGGER.error("#{t}") }
      end
    end
  end

  def spawn_thread_stream_read(buffer, mutex, condvar, stats)
    Thread.new do
      begin
        LOGGER.debug "Stream / Position: #{@stream.pos}"

        loop do
          # readpartial will block until 1 byte is avaialble. This will
          # cause the thread to sleep
          next_byte = @stream.readpartial(1)
          # TODO: deoucple stats via event
          stats[:bytes_read] += 1
          # LOGGER.debug "Stream / Byte: #{next_byte}, Current position: #{@stream.pos}"
          @log_stream.write(next_byte)

          mutex.synchronize do
            # TODO: move to queue
            buffer.push(Byte.new(:encoded, next_byte))
            # Signal any waiting threads
            condvar.signal
          end
        end
      rescue EOFError
        LOGGER.warn('Stream reached EOF!')
      rescue Exception => e
        LOGGER.error("Read thread exception..! #{e}")
        e.backtrace.each { |line| LOGGER.error line }
      end
      LOGGER.warn('Read thread is finished..!')
    end
  end

  def spawn_thread_shift(buffer, mutex, condvar, stats)
    Thread.new do
      begin
        loop do
          mutex.synchronize do
            # LOGGER.debug 'Thread / Framer acquiring lock!'
            current_frame = Frame.new

            # FRAME HEADER
            # Sleep while header not available
            condvar.wait(mutex) while buffer.size < Frame::Frame::HEADER_LENGTH
              # LOGGER.debug("Header / Insufficient bytes in buffer: #{buffer.size}")
              # LOGGER.debug("Header / Awaiting signal.")
            #   condvar.wait(mutex)
            # end

            LOGGER.debug("Header / Shifting #{Frame::HEADER_LENGTH} bytes (of #{buffer.size})")
            buffered_header = buffer.shift(Frame::HEADER_LENGTH)
            current_frame.header=(buffered_header)
            # LOGGER.debug("Header / #{current_frame.header_s}")

            # frame_length_value = frame_header[Frame::HEADER_LENGTH_FIELD_INDEX].to_d
            frame_length_value = current_frame.tail_length
            LOGGER.debug("Header / Tail Length: #{frame_length_value}")

            # FRAME TAIL
            # Sleep while tail not available
            condvar.wait(mutex) while buffer.size < frame_length_value
            #   LOGGER.debug("Tail / Insufficient bytes in buffer: #{buffer.size}")
            #   LOGGER.debug("Tail / Awaiting signal.")
            #   condvar.wait(mutex)
            # end

            LOGGER.debug("Tail / Shifting #{frame_length_value} bytes (of #{buffer.size})")
            buffered_tail = buffer.shift(frame_length_value)
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

            LOGGER.debug("Frame length is insufficient!") if current_frame.size < 5

            if frame_complete[-1].to_d == checksum && current_frame.size >= 5
              LOGGER.debug 'Frame / Checksum matches!'
              stats[:frames] += 1
              # stats[:temp] << current_frame
              @queue.push(current_frame)
              # binding.pry

              # framed = frame_complete.reduce('') do |output, byte|
              #   output = output.concat("#{byte.to_h} ")
              # end

              LOGGER.debug "Frame / #{current_frame}"

              # LOGGER.debug "binary output: #{frame_encoded}"
              # frame_complete.each {|b| @log_binary.write(b) }
              # LOGGER.debug 'Logging binary...'
              # LOGGER.debug 'binary written'

              # human_output = ""
              # frame_complete.each {|b| human_output << "#{b} " }
              # human_output.chop!
              # LOGGER.debug "Log output: #{human_output}"

              # LOGGER.debug 'Logging frame...'
              @log_frames.write_nonblock("#{current_frame}\n")
              # LOGGER.debug 'Logged frame!'
            else
              LOGGER.debug 'Checksum failed!'
              stats[:frames_failed] += 1

              LOGGER.debug "Frame / #{current_frame}"

              LOGGER.debug "Dropping byte: #{frame_complete[0]}"
              stats[:bytes_dropped] += 1
              # LOGGER.warn "Unshifting: #{frame_complete[1..-1]}"
              buffer.unshift(*frame_complete[1..-1])
            end
            # LOGGER.debug 'Thread / Framer releasing lock!'
          end # mutex
        end # loop
      rescue Exception => e
        LOGGER.error("Shift thread exception..! #{e}")
        binding.pry
      end
    end # thread_w
  end
end
