# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      module Replies
        # Manager::Replies::Devices
        module Devices
          include Logging

          def devices_callback(context)
            proc do |reply, error|
              begin
                if reply
                  logger.debug(stateful) { "#devices_callback(#{reply})" }
                  devices_reply(context, reply.properties)
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

          def devices_reply(context, reply_properties)
            logger.debug(stateful) { "#devices_reply(#{reply_properties})" }
            logger.info(stateful) { "[REPLY] Devices (#{reply_properties.size} device(s))" }
            # reply_properties.each_pair do |path, device_state|
            #   device_update(context, path, device_state)
            # end
            context.devices.update_all(reply_properties)
            context.on!
          end

          # def device_update(context, path, device_state)
          #   logger.debug(stateful) { "#device_update(#{path})" }
          #   context.devices.update(device_state[:properties], device_state[:state])
          # end
        end
      end
    end
  end
end
