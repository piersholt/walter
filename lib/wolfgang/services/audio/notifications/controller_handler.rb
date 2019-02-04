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

      CONTROLLER_HANDLER = 'Controller'

      def logger
        LogActually.notify
      end

      def take_responsibility(notification)
        logger.debug(CONTROLLER_HANDLER) { "#take_responsibility(#{notification})" }
        case notification.name
        when :everyone
          logger.info(CONTROLLER_HANDLER) { "#{:everyone}" }
          context.audio.everyone(notification.properties)
        when :player_added
          logger.info(CONTROLLER_HANDLER) { "#{:player_added}" }
          context.audio.player_added(notification.properties)
        when :player_changed
          logger.info(CONTROLLER_HANDLER) { "#{:player_changed}" }
          context.audio.player_changed(notification.properties)
        when :player_removed
          logger.info(CONTROLLER_HANDLER) { "#{:player_removed}" }
          context.audio.player_removed(notification.properties)
        when :track_change
          logger.info(CONTROLLER_HANDLER) { "#{:track_change}" }
          context.audio.track_change(notification.properties)
        when :track_start
          logger.info(CONTROLLER_HANDLER) { "#{:track_start}" }
          context.audio.track_start(notification.properties)
        when :track_end
          logger.info(CONTROLLER_HANDLER) { "#{:track_end}" }
          context.audio.track_end(notification.properties)
        when :position
          logger.info(CONTROLLER_HANDLER) { "#{:position}" }
          context.audio.position(notification.properties)
        when :status
          logger.info(CONTROLLER_HANDLER) { "#{:status}" }
          context.audio.status(notification.properties)
        when :repeat
          logger.info(CONTROLLER_HANDLER) { "#{:repeat}" }
          context.audio.repeat(notification.properties)
        when :shuffle
          logger.info(CONTROLLER_HANDLER) { "#{:shuffle}" }
          context.audio.shuffle(notification.properties)
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(CONTROLLER_HANDLER) { e }
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
