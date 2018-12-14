

class TransmissionError < StandardError
end

class Transmitter
# include Observable
  PROG_NAME = 'Transmitter'.freeze
  THREAD_NAME = "#{PROG_NAME}".freeze
  MAX_RETRY = 3

  include Observable

  attr_reader :threads, :write_queue

  alias frame_output_buffer write_queue

  def initialize(output_buffer, write_queue = Queue.new)
    @output_buffer = output_buffer
    @write_queue = write_queue
    @threads = ThreadGroup.new
  end

  def off
    LogActually.datalink.debug(PROG_NAME) { "#{self.class}#off" }
    close_threads
  end

  def disable
    LogActually.datalink.warn(PROG_NAME) { "#{self.class}#disable" }
    off
  end

  def on
    LogActually.datalink.debug(PROG_NAME) { "#{self.class}#on" }
    begin
      write_thread = thread_write_buffer(@write_queue, @output_buffer)
      @threads.add(write_thread)
    rescue StandardError => e
      LogActually.datalink.error(e)
      e.backtrace.each { |l| LogActually.datalink.error(l) }
      raise e
    end
    true
  end

  private

  # ------------------------------ THREADS ------------------------------ #

  def close_threads
    LogActually.datalink.debug "#{self.class}#close_threads"
    threads = @threads.list
    threads.each_with_index do |t, i|
      LogActually.datalink.debug "Thread ##{i+1} / #{t.status}"
      t.exit.join
      LogActually.datalink.debug "Thread ##{i+1} / #{t.status}"
    end
  end

  def thread_write_buffer(write_queue, output_buffer)
    LogActually.datalink.debug(PROG_NAME) { 'New Thread: Frame Write.' }

    Thread.new do
      Thread.current[:name] = THREAD_NAME

      begin
        loop do
          begin
            # frame_to_write = nil
            LogActually.datalink.debug(THREAD_NAME) { "Transmit queue length: #{write_queue.size}" }
            LogActually.datalink.debug(THREAD_NAME) { "Get next frame in queue... (blocking)" }
            frame_to_write = write_queue.deq
            # binding.pry
            transmit(output_buffer, frame_to_write)
          rescue TransmissionError => e
              LogActually.datalink.error(THREAD_NAME) { e }
          rescue StandardError => e
              LogActually.datalink.error(THREAD_NAME) { e }
          end # begin
        end # loop
      rescue StandardError => e
        LogActually.datalink.error(PROG_NAME) { "#{tn}: Exception: #{e}" }
        e.backtrace.each { |l| LogActually.datalink.error(l) }
        binding.pry
      end
      LogActually.datalink.warn(PROCESS_SYNC_ERROR) { "#{self.class} thread is finished..!" }
    end # thread_w
  end

  def transmit(output_buffer, frame_to_write)
    LogActually.datalink.debug(THREAD_NAME) { "#transmit(#{output_buffer}, #{frame_to_write})" }
    frams_as_string = frame_to_write.as_string
    LogActually.datalink.debug(THREAD_NAME) { "Frame as string: #{frams_as_string}" }
    result = output_buffer.write(frams_as_string)
    LogActually.datalink.debug(THREAD_NAME) { "Transmit result = #{result}" }
    return true if result
    retransmit(output_buffer, frams_as_string)
  end

  def retransmit(output_buffer, frame_to_write)
    LogActually.datalink.debug(THREAD_NAME) { "#retransmit(output_buffer, frame)" }
    attempts = 1

    LogActually.datalink.debug(THREAD_NAME) { "Enter retransmission cycle..." }
    until result || attempts > MAX_RETRY do
      LogActually.datalink.debug(THREAD_NAME) { "Retry #{attempts} of #{MAX_RETRY}" }
      back_off = Random.rand * attempts
      LogActually.datalink.debug(THREAD_NAME) { "Retry back off: #{back_off}" }
      sleep(back_off)
      result = output_buffer.write(frame_to_write)
      LogActually.datalink.debug(THREAD_NAME) { "Retry result = #{result}" }
      attempts += 1
    end

    return true if result

    # LogActually.datalink.error(THREAD_NAME) { "Retransmission failed after #{attempts} attempts!" }
    raise TransmissionError, "Retransmission failed after #{attempts} attempts!"
    return false
  end
end
