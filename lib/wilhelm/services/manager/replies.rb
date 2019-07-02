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
                logger.info(self) { "#devices_callback(#{reply})" }
                # logger.info(MANAGER) { "reply => #{reply}" }
                context.devices.update_devices(reply.properties)
                context.on
              else
                logger.warn(self) { "Error! (#{error})" }
                # context.offline!
              end
            rescue StandardError => e
              logger.error(MANAGER) { e }
              e.backtrace.each { |line| logger.error(MANAGER) { line } }
              context.change_state(Disabled.new)
            end
          end
        end
      end
    end
  end
end
