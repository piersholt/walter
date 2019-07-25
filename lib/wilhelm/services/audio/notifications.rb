# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Notifications
      module Notifications
        include Logging

        # Audio::Properties.setup_targets
        def targets_update(event, args = {})
          logger.debug(stateful) { "#{event}!" }
          case event
          when :available
            logger.info(stateful) { "#{targets.connected.count} target(s) available." }
            off!
          when :unavailable
            logger.info(stateful) { "#{targets.connected.count} target(s) available." }
            pending!
          end
        end

        # Audio::Properties.setup_players
        def players_update(event, args = {})
          logger.info(stateful) { "#{event}!" }
        end
      end
    end
  end
end
