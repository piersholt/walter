# frozen_string_literal: true

require_relative 'track/constants'
require_relative 'track/attributes'

module Wilhelm
  module Services
    class Audio
      # Audio::Track
      class Track
        include Helpers::Observation
        include Constants
        include Attributes

        def initialize(attributes = EMPTY_ATTRIBUTES.dup)
          @attributes = attributes
        end
      end
    end
  end
end
