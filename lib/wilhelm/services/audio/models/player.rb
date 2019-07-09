# frozen_string_literal: true

require_relative 'player/constants'
require_relative 'player/actions'
require_relative 'player/attributes'
require_relative 'player/notifications'
require_relative 'player/observation'
require_relative 'player/state'

module Wilhelm
  module Services
    class Audio
      # Audio::Player
      class Player
        include Constants
        include Observation
        include Attributes
        include State
        include Actions
        include Notifications

        include Logging

        def fuck_off
          LOG_NAME
        end

        # -----------

        def initialize(attributes = EMPTY_ATTRIBUTES.dup)
          @attributes = attributes
        end

        def to_s
          "#{LOG_NAME}: #{attributes}"
        end

        def inspect
          attributes
        end
      end
    end
  end
end
