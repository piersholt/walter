# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Replies
      module Replies
        include Logging

        def devices_callback(context)
          proc do |reply, error|
            begin
              if reply
                logger.info(MANAGER) { "#devices_callback(#{reply})" }
                context.devices.update_devices(reply.properties)
                context.on
              else
                logger.warn(MANAGER) { "Error! (#{error})" }
              end
            rescue StandardError => e
              logger.error(MANAGER) { e }
              e.backtrace.each { |line| logger.error(MANAGER) { line } }
              context.disable
            end
          end
        end
      end
    end
  end
end
