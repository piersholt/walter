# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Track
        # Audio::Track::Attributes
        module Attributes
          include Constants

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
            attributes.fetch(DURATION, 0)&.fdiv(1000)&.round
          end

          def attributes!(track_attributes)
            attributes.merge!(track_attributes)
          end
        end
      end
    end
  end
end
