# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class Listener
      include NotificationDelegator
      include ManageableThreads
      include Singleton

      attr_reader :listener_thread

      def logger
        LogActually.messaging
      end

      def deserialize(serialized_object)
        notification = Messaging::Serialized.new(serialized_object).parse
        logger.info(self.class) { "Deserialized: #{notification}" }
        logger.info(self.class) { "name: #{notification.name} (#{notification.name.class})" }
        notification
      end

      def pop_and_delegate(i)
        logger.debug(self.class) { "#{i}. Wait" }
        serialized_object = Subscriber.recv
        notification = deserialize(serialized_object)
        delegate(notification)
      rescue IfYouWantSomethingDone
        logger.warn(self.class) { "Chain did not handle! (#{notification})" }
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each { |line| logger.error(self.class) { line } }
      end

      def listen_loop
        i = 1
        loop do
          pop_and_delegate(i)
          i += 1
        end
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each do |line|
          logger.error(self.class) { line }
        end
      end

      def listen
        @listener_thread =
          Thread.new do
            Thread.current[:name] = 'CommandListener'
            Subscriber.pi
            Subscriber.subscribe('')
            begin
              logger.debug('CommandListener') { 'Thread listen start!' }
              listen_loop
              logger.debug('CommandListener') { 'Thread listen end!' }
            rescue StandardError => e
              logger.error(self.class) { e }
              e.backtrace.each do |line|
                logger.error(self.class) { line }
              end
            end
          end
        add_thread(@listener_thread)
      end

      def ignore
        @listener_thread.stop.join
      end

      def self.ignore
        instance.ignore
      end
    end
  end
end
