# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Replies
      module Replies
        include Logging

        def player_callback(context)
          proc do |reply, error|
            begin
              if reply
                logger.info(AUDIO) { "#player_callback(#{reply})" }
                context.public_send(reply.name, reply.properties)
              else
                logger.warn(AUDIO) { "Error! (#{error})" }
              end
            rescue StandardError => e
              logger.error(AUDIO) { e }
              e.backtrace.each { |line| logger.error(AUDIO) { line } }
              context.disable
            end
          end
        end
      end
    end
  end
end
