# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      module Notifications
        # Aud:o::Notifications::TargetHandler
        class TargetHandler
          include Singleton
          include NotificationDelegate
          include Messaging::Constants

          attr_accessor :context, :audio

          TARGET_HANDLER = 'Target'

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(TARGET_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :addressed_player
              logger.info(TARGET_HANDLER) { "#{:addressed_player}" }
              audio.addressed_player(notification.properties)
            when :player_added
              logger.info(TARGET_HANDLER) { "#{:player_added}" }
              audio.player_added(notification.properties)
            when :player_changed
              logger.info(TARGET_HANDLER) { "#{:player_changed}" }
              audio.player_changed(notification.properties)
            when :player_removed
              logger.info(TARGET_HANDLER) { "#{:player_removed}" }
              audio.player_removed(notification.properties)
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
  end
end
