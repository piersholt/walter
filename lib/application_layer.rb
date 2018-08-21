class ApplicationLayer
  # include Observable
  # include Event

  def initialize
    # @channel = channel
    # @log_frames = File.new("#{Time.now.strftime'%F'}.log",  'a')
    # @threads = ThreadGroup.new
  end

  # def on
  #   LOGGER.debug("#{self.class}#on")
  #   begin
  #     read_thread = thread_read_buffer(@channel.input_buffer)
  #     @threads.add(read_thread)
  #   rescue StandardError => e
  #     LOGGER.error(e)
  #     e.backtrace.each { |l| LOGGER.error(l) }
  #     raise e
  #   end
  #   true
  # end

  # def off
  #   LOGGER.debug "#{self.class}#off"
  #   close_threads
  # end

  def new_message(message)
    # changed
    # notify_observers(MESSAGE_DISPLAY, message: message)
    # LOGGER.debug(message.to_s)
  end

  private

  # def close_threads
  #   LOGGER.debug "#{self.class}#close_threads"
  #   threads = @threads.list
  #   threads.each_with_index do |t, i|
  #     LOGGER.debug "Thread ##{i+1} / #{t.status}"
  #     # LOGGER.debug "result = #{t.exit}"
  #     t.exit
  #     LOGGER.debug "Thread ##{i+1} / #{t.status}"
  #   end
  # end
end
