# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Requests
      module Requests
        include Logging
        include Yabber::API

        # Audio::Enabled.initialize ->
        def targets?
          logger.debug(AUDIO) { '#targets?' }
          logger.info(AUDIO) { '[REQUEST] Targets.' }
          targets!(targets_callback(self))
        end

        def player?(player_path)
          logger.debug(AUDIO) { "#player?(#{player_path})" }
          logger.info(AUDIO) { "[REQUEST] Player: #{player_path}." }
          player!(player_path, player_callback(self))
        end
      end
    end
  end
end
