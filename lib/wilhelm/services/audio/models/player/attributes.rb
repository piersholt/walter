# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Attributes
        module Attributes
          include Constants

          attr_reader :attributes

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
            attributes.fetch(TRACK, EMPTY_TRACK.dup)
          end

          # Track

          def title
            track.fetch(TITLE, EMPTY_ATTRIBUTE)
          end

          def artist
            track.fetch(ARTIST, EMPTY_ATTRIBUTE)
          end

          def album
            track.fetch(ALBUM, EMPTY_ATTRIBUTE)
          end

          def number
            track.fetch(TRACK_NUMBER, EMPTY_ATTRIBUTE)
          end

          def total
            track.fetch(NUMBER_OF_TRACKS, EMPTY_ATTRIBUTE)
          end

          def genre
            track.fetch(GENRE, EMPTY_ATTRIBUTE)
          end

          # UPDATE ------------------------------------------------------------

          def attributes!(properties_hash, attributes_hash = attributes)
            logger.unknown(fuck_off) { "attributes!(#{properties_hash}, #{attributes_hash})" }
            audit = { created: [], updated: [] }
            audit[:created] = properties_hash.keys - attributes_hash.keys

            attributes_hash.update(properties_hash) do |key, stale, fresh|
              if stale.eql?(fresh)
                stale
              elsif stale.is_a?(Hash)
                attributes!(fresh, stale)
              else
                # logger.warn(fuck_off) { "#{stale}.eql?(#{fresh}) => false" }
                audit[:updated] << key
                fresh
              end
            end
            logger.unknown(fuck_off) { "=> #{audit}" }
            audit
          end

          def squish(stale, fresh)
            stale.merge(fresh) do |key, stale, fresh|
              if fresh.is_a?(String)
                fresh.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, { undef: :replace })
              else
                fresh
              end
            end
          end
        end
      end
    end
  end
end
