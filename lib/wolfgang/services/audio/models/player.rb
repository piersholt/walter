# frozen_string_literal: true

module Wolfgang
  class Audio
    # Comment
    class Player
      include Logger
      include Observable

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

      attr_reader :attributes

      alias add_observer! add_observer

      def add_observer(object, method = nil)
        raise StandardError, 'Duplicate!' if @observer_peers&.keys&.include?(object)
        add_observer!(object, method)
      end

      def initialize(attributes = {})
        @attributes = attributes
      end

      def to_s
        attributes
      end

      def inspect
        attributes
      end

      # EVENTS ------------------------------------------------------------

      def addressed_player!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:addressed_player, player: self)
      end

      def track_change!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:track_change, player: self)
      end

      def track_start!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:track_start, player: self)
      end

      def track_end!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:track_end, player: self)
      end

      def position!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:position, player: self)
      end

      def status!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:status, player: self)
      end

      def repeat!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:repeat, player: self)
      end

      def shuffle!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:shuffle, player: self)
      end

      # ATTRIBUTES ------------------------------------------------------------

      def device
        attributes.fetch(DEVICE, '')
      end

      def name
        attributes.fetch(NAME, '')
      end

      def type
        attributes.fetch(TYPE, '')
      end

      def subtype
        attributes.fetch(SUBTYPE, '')
      end

      def browseable
        attributes.fetch(BROWSEABLE, '')
      end

      def searchable
        attributes.fetch(SEARCHABLE, '')
      end

      def playlist
        attributes.fetch(PLAYLIST, '')
      end

      def equalizer
        attributes.fetch(EQUALIZER, '')
      end

      def repeat
        attributes.fetch(REPEAT, '')
      end

      def shuffle
        attributes.fetch(SHUFFLE, '')
      end

      def scan
        attributes.fetch(SCAN, '')
      end

      def status
        attributes.fetch(STATUS, '')
      end

      def position
        attributes.fetch(POSITION, '')
      end

      def track
        attributes.fetch(TRACK, { title: nil, artist: nil, album: nil, number: nil, total: nil, genre: nil })
      end

      def title
        track.fetch('Title', '')
      end

      def artist
        track.fetch('Artist', '')
      end

      def album
        track.fetch('Album', '')
      end

      def number
        track.fetch('TrackNumber', '')
      end

      def total
        track.fetch('NumberOfTracks', '')
      end

      def genre
        track.fetch('Genre', '')
      end

      # UPDATE ------------------------------------------------------------

      def attributes!(new_object)
        changed = []
        attributes.merge!(new_object.attributes) do |key, old, new|
          changed << key
          # old.is_a?(Hash) ?  : new
          if old.is_a?(Hash)
            squish(old, new)
          elsif old.is_a?(String) || new.is_a?(String)
            new.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, {undef: :replace, replace: 130.chr})
          else
            new
          end
        end
        # changed
        # notify_observers(:updated, changed: changed, player: self)
      end

      def squish(old, new)
        old.merge(new) do |key, old, new|
          if new.is_a?(String)
            new.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, {undef: :replace, replace: 130.chr})
          else
            new
          end
        end
      end
    end
  end
end
