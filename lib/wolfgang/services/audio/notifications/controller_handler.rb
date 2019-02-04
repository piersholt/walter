# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class ControllerHandler
      include Singleton
      include NotificationDelegate
      include Messaging::Constants

      attr_accessor :context

      def logger
        LogActually.messaging
      end

      def take_responsibility(notification)
        logger.debug(self.class.name) { "#take_responsibility(#{notification})" }
        case notification.name
        when :everyone
          logger.info(self.class.name) { "#{:everyone}" }
          context.audio.everyone(notification.properties)
        when :player_added
          logger.info(self.class.name) { "#{:player_added}" }
          context.audio.player_added(notification.properties)
        when :player_changed
          logger.info(self.class.name) { "#{:player_changed}" }
          context.audio.player_changed(notification.properties)
        when :player_removed
          logger.info(self.class.name) { "#{:player_removed}" }
          context.audio.player_removed(notification.properties)
        when :track_change
          logger.info(self.class.name) { "#{:track_change}" }
          context.audio.track_change(notification.properties)
        when :track_start
          logger.info(self.class.name) { "#{:track_start}" }
          context.audio.track_start(notification.properties)
        when :track_end
          logger.info(self.class.name) { "#{:track_end}" }
          context.audio.track_end(notification.properties)
        when :position
          logger.info(self.class.name) { "#{:position}" }
          context.audio.position(notification.properties)
        when :status
          logger.info(self.class.name) { "#{:status}" }
          context.audio.status(notification.properties)
        when :repeat
          logger.info(self.class.name) { "#{:repeat}" }
          context.audio.repeat(notification.properties)
        when :shuffle
          logger.info(self.class.name) { "#{:shuffle}" }
          context.audio.shuffle(notification.properties)
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(self.class.name) { e }
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
