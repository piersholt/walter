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

      PLAYER_HANDLER = 'Player'

      def logger
        LogActually.notify
      end

      def take_responsibility(notification)
        logger.debug(PLAYER_HANDLER) { "#take_responsibility(#{notification})" }
        case notification.name
        when :track_change
          logger.info(PLAYER_HANDLER) { "#{:track_change}" }
          context.audio.track_change(notification.properties)
        when :track_start
          logger.info(PLAYER_HANDLER) { "#{:track_start}" }
          context.audio.track_start(notification.properties)
        when :track_end
          logger.info(PLAYER_HANDLER) { "#{:track_end}" }
          context.audio.track_end(notification.properties)
        when :position
          logger.info(PLAYER_HANDLER) { "#{:position}" }
          context.audio.position(notification.properties)
        when :status
          logger.info(PLAYER_HANDLER) { "#{:status}" }
          context.audio.status(notification.properties)
        when :repeat
          logger.info(PLAYER_HANDLER) { "#{:repeat}" }
          context.audio.repeat(notification.properties)
        when :shuffle
          logger.info(PLAYER_HANDLER) { "#{:shuffle}" }
          context.audio.shuffle(notification.properties)
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(PLAYER_HANDLER) { e }
        e.backtrace.each { |l| logger.error(l) }
      end

      def responsibility
        PLAYER
      end
    end
  end
end
