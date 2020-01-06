# frozen_string_literal: false

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Defaults
        module Defaults
          include Logging

          def load_ui(*); end

          def online!(*); end

          def offline!(*); end

          def establishing!(*); end

          def open(*); end

          def close(*); end

          def notifications!(*); end

          def ui!(*); end

          def load_context(*); end

          def alive?(*); end

          def shutdown(___, toggle)
            logger.debug(self) { "#shutdown(#{toggle})" }
            case toggle
            when :on
              logger.warn(self) { `/usr/bin/sudo /sbin/shutdown -h now` }
            when :off
              false
            end
          end
        end
      end
    end
  end
end
