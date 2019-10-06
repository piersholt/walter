# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Monitor::Capabilities::Monitor
          module Monitor
            include API
            include Constants
            include Helpers::Parse

            def monitor(*args)
              src_gfx(arguments: bytes(*args))
            end
          end
        end
      end
    end
  end
end
