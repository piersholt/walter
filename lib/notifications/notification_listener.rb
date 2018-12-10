# frozen_string_literal: true

# Comment
class NotificationListener
  attr_accessor :handler, :thread

  def initialize(subscriber)
    @subscriber = subscriber
  end

  def setup
    Subscriber.pi
    Subscriber.subscribe(:device)
    Subscriber.subscribe(:target)
    Subscriber.subscribe(:player)
  end

  def delegate(notification)
    handler.oi(notification)
  end

  def listen
    @thread = Thread.new do
      begin
        setup
        LOGGER.warn('Notification') { 'Thread start!' }
        i = 1
        loop do
          LOGGER.warn('Notification') { "#{i}. Wait" }
          notification = Subscriber.recv
          LOGGER.warn('Notification') { "#{i}. #{notification}" }
          delegate(notification)
          i += 1
        end
        LOGGER.warn('Notification') { 'Thread end!' }
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each do |line|
          LOGGER.error(self.class) { line }
        end
      end
    end
  end
end
