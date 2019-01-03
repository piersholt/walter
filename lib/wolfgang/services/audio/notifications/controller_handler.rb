# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class ControllerHandler
      include Singleton
      include NotificationDelegate
      include Messaging::Constants

      attr_accessor :bus

      def logger
        LogActually.messaging
      end

      def take_responsibility(notification)
        logger.debug(self.class) { "#take_responsibility(#{notification})" }
        case notification.name
        when :track_change
          track = notification.properties
          LogActually.messaging.debug(self.class) { track }
          bus.rad.track_change(track)
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each { |l| logger.error(l) }
      end
      #
      # def responsible?(notification)
      #   result = notification.topic == responsibility
      #   LOGGER.debug(self.class) { "#{notification.topic} == #{responsibility} => #{result}" }
      #   result
      # end

      def responsibility
        CONTROLLER
      end
    end
  end
end
