# frozen_string_literal: true

# Comment
module Wolfgang
  class Notifications
    # Comment
    class TargetHandler
      include Singleton
      include NotificationDelegate
      include Messaging::Constants

      attr_accessor :context

      TARGET_HANDLER = 'Target'

      def logger
        LogActually.audio_service
      end

      def take_responsibility(notification)
        logger.debug(TARGET_HANDLER) { "#take_responsibility(#{notification})" }
        case notification.name
        when :addressed_player
          logger.info(TARGET_HANDLER) { "#{:addressed_player}" }
          context.audio.addressed_player(notification.properties)
        when :player_added
          logger.info(TARGET_HANDLER) { "#{:player_added}" }
          context.audio.player_added(notification.properties)
        when :player_changed
          logger.info(TARGET_HANDLER) { "#{:player_changed}" }
          context.audio.player_changed(notification.properties)
        when :player_removed
          logger.info(TARGET_HANDLER) { "#{:player_removed}" }
          context.audio.player_removed(notification.properties)
        else
          not_handled(notification)
        end
      rescue StandardError => e
        logger.error(TARGET_HANDLER) { e }
        e.backtrace.each { |l| logger.error(l) }
      end

      def responsibility
        TARGET
      end
    end
  end
end
