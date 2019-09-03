# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Players
      class Players < Collection
        include Helpers::Name

        PROG = 'Audio::Players'
        EXCLAIM = '!'

        # HANDLER

        def update(player_attributes_hash, notification = nil)
          player = create_or_update(player_attributes_hash)
          player.public_send(symbol_concat(notification, EXCLAIM)) if notification
        rescue StandardError => e
          logger.error(PROG) { e }
          e.backtrace.each { |line| logger.error(PROG) { line } }
        end

        # Observable.notify
        def player_update(notification, player:)
          logger.debug(PROG) { "#player_update(#{notification}, #{player})" }
          case notification
          # @todo sync player state if alredy on?
          when :status
            true
          when :updated
            true
          else
            logger.warn(PROG) { "Player Update unknown: #{notification}!" }
          end
        end

        # COLLECTION

        def update_method
          :player_update
        end

        def klass
          Player
        end
      end
    end
  end
end
