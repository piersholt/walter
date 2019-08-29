# frozen_string_literal: true

require_relative 'player/constants'
require_relative 'player/actions'
require_relative 'player/attributes'
require_relative 'player/notifications'
require_relative 'player/state'

module Wilhelm
  module Services
    class Audio
      # Audio::Player
      class Player
        include Logging
        include Constants
        include Helpers::Observation
        include Attributes
        include State
        include Actions
        include Notifications

        def initialize(attributes = EMPTY_ATTRIBUTES.dup)
          @attributes = attributes
        end

        def timer
          @timer ||= Timer.new
        end
      end
    end
  end
end
