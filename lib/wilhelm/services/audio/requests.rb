# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Requests
      module Requests
        include Logging

        def player?
          player!(player_callback(self))
        end
      end
    end
  end
end
