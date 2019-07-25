# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Track
        # Audio::Target::Constants
        module Constants
          PROG = 'Audio::Model::Track'

          TITLE            = :title
          ARTIST           = :artist
          ALBUM            = :album
          TRACK_NUMBER     = :tracknumber
          NUMBER_OF_TRACKS = :numberoftracks
          GENRE            = :genre
          DURATION         = :duration

          EMPTY_ATTRIBUTE = ''
          EMPTY_ATTRIBUTES = {}.freeze
        end
      end
    end
  end
end
