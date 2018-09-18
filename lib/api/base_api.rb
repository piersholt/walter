module API
  module BaseAPI
    include Event
    include Observable

    def deliver(from, to, command)
      begin
        message = Message.new(from, to, command)
        send_message(message)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end

    def send_message(message)
      begin
        changed
        notify_observers(MESSAGE_SENT, message: message)
        message
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end
  end
end
