# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Replies
      module Replies
        include Logging

        def targets_callback(context)
          proc do |reply, error|
            begin
              if reply
                logger.debug(stateful) { "#targets_callback(#{reply})" }
                targets_reply(context, reply.properties)
              else
                logger.warn(stateful) { "Error! (#{error})" }
              end
            rescue StandardError => e
              logger.error(stateful) { e }
              e.backtrace.each { |line| logger.error(stateful) { line } }
              context.disable!
            end
          end
        end

        def player_callback(context)
          proc do |reply, error|
            begin
              if reply
                logger.debug(stateful) { "#player_callback(#{reply})" }
                player_reply(context, reply.properties)
              else
                logger.warn(stateful) { "Error! (#{error})" }
              end
            rescue StandardError => e
              logger.error(stateful) { e }
              e.backtrace.each { |line| logger.error(stateful) { line } }
              context.disable!
            end
          end
        end

        def targets_reply(context, reply_properties)
          logger.debug(stateful) { "#targets_reply(#{reply_properties})" }
          logger.info(stateful) { "[REPLY] Targets (#{reply_properties.size} target(s))" }

          reply_properties.each_pair do |_, target_state|
            context.targets.update(target_state[:properties], target_state[:state])
          end
        end

        def player_reply(context, properties)
          logger.debug(stateful) { "#player_reply(#{properties})" }
          logger.info(stateful) { "[REPLY] Player: #{properties}." }

          context.players.update(properties, :updated)
        end
      end
    end
  end
end
