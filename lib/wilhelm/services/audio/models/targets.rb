# frozen_string_literal: true

require_relative 'targets/selection'

module Wilhelm
  module Services
    class Audio
      # Audio::Targets
      class Targets < Collection
        PROG = 'Audio::Targets'

        include Selection

        attr_reader :context

        def initialize(context)
          @context = context
        end

        # SCOPE

        def connected
          values.find_all(&:connected?)
        end

        def disconnected
          values.find_all(&:disconnected?)
        end

        # HANDLER

        def update(target_attributes_hash, notification = nil)
          target = create_or_update(target_attributes_hash)
          target.public_send(notification) if notification
        rescue StandardError => e
          logger.error(PROG) { e }
          e.backtrace.each { |line| logger.error(PROG) { line } }
        end

        # Observable.notify
        def target_update(notification, target:)
          logger.debug(PROG) { "#target_update(#{notification}, #{target})" }
          case notification
          when :added
            logger.info(PROG) { "Target: #{notification}: #{target.id}" }
            target.players = context.players
            select_target(target) unless selected_id?
            if connected.count >= 1
              changed
              notify_observers(:available, target: target)
            end
          when :changed
            logger.debug(PROG) { "Target: #{notification}: #{target.id}" }
          when :removed
            logger.info(PROG) { "Target: #{notification}: #{target.id}" }
            if connected.count >= 1
              select_target(first)
            elsif connected.count.zero?
              deselect_target if selected_id?
              changed
              notify_observers(:unavailable, target: target)
            end
          else
            logger.warn(PROG) { "Target Update unknown: #{notification}!" }
          end
        end

        # COLLECTION

        def update_method
          :target_update
        end

        def klass
          Target
        end
      end
    end
  end
end
