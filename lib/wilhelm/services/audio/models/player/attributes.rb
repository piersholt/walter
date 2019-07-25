# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Attributes
        module Attributes
          include Constants

          attr_reader :attributes

          def path
            attributes[:path]
          end

          alias id path

          def device
            attributes.fetch(DEVICE, EMPTY_ATTRIBUTE)
          end

          def name
            attributes.fetch(NAME, EMPTY_ATTRIBUTE)
          end

          def type
            attributes.fetch(TYPE, EMPTY_ATTRIBUTE)
          end

          def subtype
            attributes.fetch(SUBTYPE, EMPTY_ATTRIBUTE)
          end

          def browseable
            attributes.fetch(BROWSEABLE, EMPTY_ATTRIBUTE)
          end

          def searchable
            attributes.fetch(SEARCHABLE, EMPTY_ATTRIBUTE)
          end

          def playlist
            attributes.fetch(PLAYLIST, EMPTY_ATTRIBUTE)
          end

          def equalizer
            attributes.fetch(EQUALIZER, EMPTY_ATTRIBUTE)
          end

          def repeat
            attributes.fetch(REPEAT, EMPTY_ATTRIBUTE)
          end

          def shuffle
            attributes.fetch(SHUFFLE, EMPTY_ATTRIBUTE)
          end

          def scan
            attributes.fetch(SCAN, EMPTY_ATTRIBUTE)
          end

          def status
            attributes.fetch(STATUS, EMPTY_ATTRIBUTE)
          end

          def position
            attributes.fetch(POSITION, EMPTY_ATTRIBUTE)
          end

          def track
            # attributes.fetch(TRACK, EMPTY_TRACK.dup)
            @track ||= Track.new(attributes.fetch(TRACK, EMPTY_ATTRIBUTE))
          end

          # Track

          def title
            track.title
          end

          def artist
            track.artist
          end

          def album
            track.album
          end

          def track_number
            track.track_number
          end

          alias number track_number

          def number_of_tracks
            track.number_of_tracks
          end

          alias tracks number_of_tracks
          alias total number_of_tracks

          def genre
            track.genre
          end

          def duration
            track.duration
          end

          # UPDATE ------------------------------------------------------------

          def attributes!(player_object)
            logger.debug(PROG) { "#attributes!(#{player_object&.attributes})" }
            attributes.merge!(player_object.attributes) do |key, _, fresh|
              key == TRACK ? track.attributes!(fresh) : fresh
            end
          end

          # def squish(stale, fresh)
          #   stale.merge(fresh) do |key, stale, fresh|
          #     if fresh.is_a?(String)
          #       fresh.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, { undef: :replace })
          #     else
          #       fresh
          #     end
          #   end
          # end
        end
      end
    end
  end
end
