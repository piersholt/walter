# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module TV
        module Capabilities
          # TV::Capabilities::Monitor
          module Monitor
            include API
            include Constants
            include Helpers::Parse

            def monitor(*args)
              src_gt(arguments: bytes(*args))
            end
          end
        end
      end
    end
  end
end
