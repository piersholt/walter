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

      def initialize(attributes = {})
        @attributes = attributes
      end

      # EVENTS ------------------------------------------------------------

      def everyone!(player_object)
        attributes!(player_object)
        changed
        notify_observers(:everyone, player: self)
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

      def track
        attributes[TRACK] || {}
      end

      def device
        attributes[DEVICE]
      end

      def name
        attributes[NAME]
      end

      def type
        attributes[TYPE]
      end

      def subtype
        attributes[SUBTYPE]
      end

      def browseable
        attributes[BROWSEABLE]
      end

      def searchable
        attributes[SEARCHABLE]
      end

      def playlist
        attributes[PLAYLIST]
      end

      def equalizer
        attributes[EQUALIZER]
      end

      def repeat
        attributes[REPEAT]
      end

      def shuffle
        attributes[SHUFFLE]
      end

      def scan
        attributes[SCAN]
      end

      def status
        attributes[STATUS]
      end

      def title
        track['Title']
      end

      def artist
        track['Artist']
      end

      def album
        track['Album']
      end

      def number
        track['Number']
      end

      def total
        track['Total']
      end

      def genre
        track['Genre']
      end

      def position
        attributes[POSITION]
      end

      # UPDATE ------------------------------------------------------------

      def attributes!(new_object)
        changed = []
        attributes.merge!(new_object.attributes) do |key, old, new|
          changed << key
          old.is_a?(Hash) ? squish(old, new) : new
        end
        # changed
        # notify_observers(:updated, changed: changed, player: self)
      end

      def squish(old, new)
        old.merge(new)
      end
    end
  end
end
