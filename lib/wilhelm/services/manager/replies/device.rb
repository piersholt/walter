# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      module Replies
        # Manager::Replies::Device
        module Device
          include Logging

          def device_callback(context)
            proc do |reply, error|
              begin
                if reply
                  logger.debug(stateful) { "#device_callback(#{reply})" }
                  device_reply(context, reply.properties)
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

          def device_reply(context, reply_properties)
            logger.warn(stateful) { "DISABLED #device_reply" }
            return false
            logger.debug(stateful) { "#device_reply(#{reply_properties})" }
            logger.info(stateful) { "[REPLY] Device: #{reply_properties}." }
            reply_properties.each_pair do |path, device_state|
              device_update(context, path, device_state)
            end
          end
        end
      end
    end
  end
end
