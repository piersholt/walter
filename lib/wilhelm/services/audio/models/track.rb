# frozen_string_literal: true

require_relative 'track/constants'

module Wilhelm
  module Services
    class Audio
      # Audio::Track
      class Track
        include Helpers::Observation
        include Constants

        def initialize(attributes = EMPTY_ATTRIBUTES.dup)
          @attributes = attributes
        end

        attr_reader :attributes

        # Track

        def title
          attributes.fetch(TITLE, EMPTY_ATTRIBUTE)
        end

        def artist
          attributes.fetch(ARTIST, EMPTY_ATTRIBUTE)
        end

        def album
          attributes.fetch(ALBUM, EMPTY_ATTRIBUTE)
        end

        def track_number
          attributes.fetch(TRACK_NUMBER, EMPTY_ATTRIBUTE)
        end

        alias number track_number

        def number_of_tracks
          attributes.fetch(NUMBER_OF_TRACKS, EMPTY_ATTRIBUTE)
        end

        alias tracks number_of_tracks
        alias total number_of_tracks

        def genre
          attributes.fetch(GENRE, EMPTY_ATTRIBUTE)
        end

        def duration
          attributes.fetch(DURATION, EMPTY_ATTRIBUTE)
        end

        def attributes!(track_attributes)
          attributes.merge!(track_attributes)
        end
      end
    end
  end
end
