# frozen_string_literal: true

module Wilhelm
  class Audio
    # Comment
    class Player
      include Constants
      include Observable
      include Messaging::API

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

      LOG_NAME = 'AddressedPlayer'

      def fuck_off
        LOG_NAME
      end

      # OBSERVEABLE -----

      alias add_observer! add_observer
      alias delete_observer! delete_observer

      def add_observer(object, method = nil)
        logger.debug(fuck_off) { "#add_observer(#{object.class}:#{Kernel.format('%#.14x',(object.object_id * 2))})" }
          raise ArgumentError, 'Duplicate!' if
            @observer_peers&.keys&.find do |observer, method|
              observer.class == object.class
            end
        # raise ArgumentError, 'Duplicate!' if @observer_peers&.keys&.include?(object)
        add_observer!(object, method)
      end

      def delete_observer(object)
        logger.debug(fuck_off) { "#delete_observer(#{object.class}:#{Kernel.format('%#.14x',(object.object_id * 2))})" }
        # raise ArgumentError, 'Duplicate!' if @observer_peers&.keys&.include?(object)
        delete_observer!(object)
      end

      def observers
        x = instance_variable_get(:@observer_peers)
        x.map do |observer, method|
          klass = observer.class
          id = Kernel.format('%#.14x',(observer.object_id * 2))
          ["#{klass}:#{id}", method]
        end&.to_h
      end

      # -----------

      def initialize(attributes = {})
        @attributes = attributes
        # attributes!(self)
      end

      def to_s
        attributes
      end

      def inspect
        attributes
      end

      def power?
        if on?
          true
        elsif off?
          false
        else
          false
        end
      end

      # WHATEVER ------------------------------------------------------------
      def power
        if on?
          stop!
          false
        else
          play!
          true
        end
      end

      def pause
        if play?
          pause!
          true
        elsif paused?
          play!
          false
        end
      end

      def seek_forward
        return false unless on?
        next!
      end

      def seek_backward
        return false unless on?
        previous!
      end

      def scan_forward_start
        scan_forward_start!
      end

      def scan_forward_stop
        scan_forward_stop!
      end

      def scan_backward_start
        scan_backward_start!
      end

      def scan_backward_stop
        scan_backward_stop!
      end

      def on?
        %w[playing forward-seek reverse-seek].one? { |s| s == status }
      end

      alias play? on?

      def off?
        %w[stopped paused error].one? { |s| s == status }
      end

      def paused?
        %w[stopped paused].one? { |s| s == status }
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
        attributes.fetch(TRACK, { title: '', artist: '', album: '', number: '', total: '', genre: '' })
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
        # changed = []
        attributes.merge!(new_object.attributes) do |key, old, new|
          # changed << key
          # old.is_a?(Hash) ?  : new
          if old.is_a?(Hash)
            squish(old, new)
          elsif old.is_a?(String) || new.is_a?(String)
            new.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, { undef: :replace })
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
            new.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, { undef: :replace })
          else
            new
          end
        end
      end
    end
  end
end
