# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      module Notifications
        # Audio::Notifications::PlayerHandler
        class PlayerHandler
          include Singleton
          include Yabber::NotificationDelegate
          include Yabber::Constants

          attr_accessor :context, :audio

          PLAYER_HANDLER = 'Handler::Player'

          def notification_delegate
            PLAYER_HANDLER
          end

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(PLAYER_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :track_start
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":track_start => #{id}" }
              audio.players.update(notification.properties, :track_start)
            when :track_pending
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":track_pending => #{id}" }
              audio.players.update(notification.properties, :track_pending)
            when :track_change
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":track_change => #{id}" }
              audio.players.update(notification.properties, :track_change)
            when :track_end
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":track_end => #{id}" }
              audio.players.update(notification.properties, :track_end)
            when :position
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":position => #{id}" }
              audio.players.update(notification.properties, :position)
            when :status
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":status => #{id}" }
              audio.players.update(notification.properties, :status)
            when :updated
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":updated => #{id}" }
              audio.players.update(notification.properties, :updated)
            when :created
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(PLAYER_HANDLER) { ":created => #{id}" }
              audio.players.update(notification.properties, :created)
            else
              not_handled(notification)
            end
          rescue StandardError => e
            logger.error(PLAYER_HANDLER) { e }
            e.backtrace.each { |l| logger.error(PLAYER_HANDLER) { l } }
          end

          def responsibility
            PLAYER
          end
        end
      end
    end
  end
end
