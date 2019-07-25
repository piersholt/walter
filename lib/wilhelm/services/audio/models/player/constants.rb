# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Constants
        module Constants
          TRACK = 'Track'.to_sym.downcase
          DEVICE = 'Device'.to_sym.downcase
          NAME = 'Name'.to_sym.downcase
          TYPE = 'Type'.to_sym.downcase
          SUBTYPE = 'Subtype'.to_sym.downcase
          BROWSEABLE = 'Browseable'.to_sym.downcase
          SEARCHABLE = 'Searchable'.to_sym.downcase
          PLAYLIST = 'Playlist'.to_sym.downcase
          EQUALIZER = 'Equalizer'.to_sym.downcase
          REPEAT = 'Repeat'.to_sym.downcase
          SHUFFLE = 'Shuffle'.to_sym.downcase
          SCAN = 'Scan'.to_sym.downcase
          STATUS = 'Status'.to_sym.downcase
          POSITION = 'Position'.to_sym.downcase

          TITLE = 'Title'.to_sym.downcase
          ARTIST = 'Artist'.to_sym.downcase
          ALBUM = 'Album'.to_sym.downcase
          TRACK_NUMBER = 'TrackNumber'.to_sym.downcase
          NUMBER_OF_TRACKS = 'NumberOfTracks'.to_sym.downcase
          DURATION = 'Duration'.to_sym.downcase
          GENRE = 'Genre'.to_sym.downcase

          PROG = 'Audio::Model::Player'

          STATUS_ON = %w[playing forward-seek reverse-seek].freeze
          STATUS_OFF = %w[stopped paused error].freeze
          STATUS_PAUSE = %w[stopped paused error].freeze

          EMPTY_ATTRIBUTES = { TRACK => nil }.freeze

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
