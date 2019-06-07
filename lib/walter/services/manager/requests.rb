# frozen_string_literal: true

class Walter
  class Manager
    # Comment
    module Requests
      include Constants

      def devices?
        devices!(devices_callback(self))
      end

      def devices_callback(context)
        proc do |reply, error|
          begin
            if reply
              logger.info(MANAGER) { "#devices_callback(#{reply})" }
              # logger.info(MANAGER) { "reply => #{reply}" }
              context.devices.update_devices(reply.properties)
              context.on
            else
              logger.warn(MANAGER) { "Error! (#{error})" }
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
