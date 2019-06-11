# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class Listener
      include NotificationDelegator
      include ManageableThreads
      include Singleton
      include Constants

      attr_reader :listener_thread

      # def logger
      #   LogActually.messaging
      # end

      def deserialize(serialized_object)
        notification = Messaging::Serialized.new(serialized_object).parse
        logger.debug(NOTIFICATIONS_LISTENER) { "Deserialized: #{notification}" }
        # logger.debug(NOTIFICATIONS_LISTENER) { "name: #{notification.name} (#{notification.name.class})" }
        notification
      end

      def logger
        LogActually.notify
      end

      def pop_and_delegate(i)
        logger.debug(NOTIFICATIONS_LISTENER) { "#{i}. Wait" }
        serialized_object = Subscriber.recv
        logger.debug(NOTIFICATIONS_LISTENER) { "#{i}. Received: #{serialized_object}" }
        notification = deserialize(serialized_object)
        logger.debug(NOTIFICATIONS_LISTENER) { "#{i}. Deserialzed: #{notification}" }
        delegate(notification)
      rescue IfYouWantSomethingDone
        logger.debug(NOTIFICATIONS_LISTENER) { "Chain did not handle! (#{notification})" }
      rescue StandardError => e
        logger.error(NOTIFICATIONS_LISTENER) { e }
        e.backtrace.each { |line| logger.error(NOTIFICATIONS_LISTENER) { line } }
      end

      def listen_loop
        i = 1
        loop do
          pop_and_delegate(i)
          i += 1
        end
      rescue StandardError => e
        logger.error(NOTIFICATIONS_LISTENER) { e }
        e.backtrace.each do |line|
          logger.error(NOTIFICATIONS_LISTENER) { line }
        end
      end

      def listen
        @listener_thread =
          Thread.new do
            Thread.current[:name] = 'NotificationsListener'
            connection_options =
              { port: ENV['subscriber_port'],
                host: ENV['subscriber_host'] }
            logger.warn(NOTIFICATIONS_LISTENER) { "Subscriber connection options: #{connection_options}" }
            Subscriber.params(connection_options)
            begin
              logger.debug(NOTIFICATIONS_LISTENER) { 'Thread listen start!' }
              listen_loop
              logger.debug(NOTIFICATIONS_LISTENER) { 'Thread listen end!' }
            rescue StandardError => e
              logger.error(NOTIFICATIONS_LISTENER) { e }
              e.backtrace.each do |line|
                logger.error(NOTIFICATIONS_LISTENER) { line }
              end
            end
          end
        add_thread(@listener_thread)
      end

      def stop
        logger.debug(NOTIFICATIONS_LISTENER) { '#stop' }
        result = @listener_thread.exit.join
        logger.debug(NOTIFICATIONS_LISTENER) { "#exit => Status: #{result.status}, Stopped?: #{result.stop?}" }
        result
      end

      def self.stop
        instance.stop
      end
    end
  end
end