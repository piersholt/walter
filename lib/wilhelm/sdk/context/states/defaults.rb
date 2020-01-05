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

          def manager!(*); end

          def audio!(*); end

          def notifications!(*); end

          def ui!(*); end

          def load_debug(*); end

          def load_services(*); end

          def load_manager(*); end

          def load_audio(*); end

          def load_now_playing(*); end

          def alive?(*); end

          def shutdown
            LOGGER.warn(stateful) { `/usr/bin/sudo /sbin/shutdown -h now` }
          end
        end
      end
    end
  end
end
