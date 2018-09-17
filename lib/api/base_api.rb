module API
  module BaseAPI
    include Event
    include Observable

    def post(message)
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
