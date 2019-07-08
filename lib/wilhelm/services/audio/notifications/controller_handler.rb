# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      module Notifications
        # Audio::Notifications::ControllerHandler
        class ControllerHandler
          include Singleton
          include Yabber::NotificationDelegate
          include Yabber::Constants

          attr_accessor :context, :audio

          PLAYER_HANDLER = 'Audio::ControllerHandler'

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(PLAYER_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :track_change
              logger.info(PLAYER_HANDLER) { "#{:track_change}" }
              audio.track_change(notification.properties)
            when :track_start
              logger.info(PLAYER_HANDLER) { "#{:track_start}" }
              audio.track_start(notification.properties)
            when :track_end
              logger.info(PLAYER_HANDLER) { "#{:track_end}" }
              audio.track_end(notification.properties)
            when :position
              logger.info(PLAYER_HANDLER) { "#{:position}" }
              audio.position(notification.properties)
            when :status
              logger.info(PLAYER_HANDLER) { "#{:status}" }
              audio.status(notification.properties)
            when :repeat
              logger.info(PLAYER_HANDLER) { "#{:repeat}" }
              audio.repeat(notification.properties)
            when :shuffle
              logger.info(PLAYER_HANDLER) { "#{:shuffle}" }
              audio.shuffle(notification.properties)
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
  end
end
