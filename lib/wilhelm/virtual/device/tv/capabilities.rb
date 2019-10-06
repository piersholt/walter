# frozen_string_literal: false

require_relative 'capabilities/constants'

require_relative 'capabilities/monitor'
require_relative 'capabilities/settings'

module Wilhelm
  module Virtual
    class Device
      module TV
        # Device::TV
        module Capabilities
          include Monitor
          include Settings
        end
      end
    end
  end
end
