# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Constants
        module Constants
          TRACK = 'Track'
          DEVICE = 'Device'
          NAME = 'Name'
          TYPE = 'Type'
          SUBTYPE = 'Subtype'
          BROWSEABLE = 'Browseable'
          SEARCHABLE = 'Searchable'
          PLAYLIST = 'Playlist'
          EQUALIZER = 'Equalizer'
          REPEAT = 'Repeat'
          SHUFFLE = 'Shuffle'
          SCAN = 'Scan'
          STATUS = 'Status'
          POSITION = 'Position'

          TITLE = 'Title'
          ARTIST = 'Artist'
          ALBUM = 'Album'
          TRACK_NUMBER = 'TrackNumber'
          NUMBER_OF_TRACKS = 'NumberOfTracks'
          GENRE = 'Genre'

          LOG_NAME = 'Audio::Player'

          STATUS_ON = %w[playing forward-seek reverse-seek].freeze
          STATUS_OFF = %w[stopped paused error].freeze
          STATUS_PAUSE = %w[stopped paused error].freeze

          EMPTY_ATTRIBUTES = {}.freeze

          EMPTY_ATTRIBUTE = ''
          EMPTY_TRACK = {
            TITLE => EMPTY_ATTRIBUTE,
            ARTIST => EMPTY_ATTRIBUTE,
            ALBUM => EMPTY_ATTRIBUTE,
            TRACK_NUMBER => EMPTY_ATTRIBUTE,
            NUMBER_OF_TRACKS => EMPTY_ATTRIBUTE,
            GENRE => EMPTY_ATTRIBUTE
          }.freeze
        end
      end
    end
  end
end
