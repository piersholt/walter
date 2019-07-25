# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      module Notifications
        # Aud:o::Notifications::TargetHandler
        class TargetHandler
          include Singleton
          include Yabber::NotificationDelegate
          include Yabber::Constants

          attr_accessor :context, :audio

          TARGET_HANDLER = 'Handler::Target'

          def notification_delegate
            TARGET_HANDLER
          end

          def logger
            LOGGER
          end

          def take_responsibility(notification)
            logger.debug(TARGET_HANDLER) { "#take_responsibility(#{notification})" }
            case notification.name
            when :added
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(TARGET_HANDLER) { ":added => #{id}" }
              audio.targets.update(notification.properties, :added)
            when :updated
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(TARGET_HANDLER) { ":updated => #{id}" }
              audio.targets.update(notification.properties, :updated)
            when :removed
              id = notification.properties.fetch(:path, 'unknown?')
              logger.info(TARGET_HANDLER) { ":removed => #{id}" }
              audio.targets.update(notification.properties, :removed)
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
