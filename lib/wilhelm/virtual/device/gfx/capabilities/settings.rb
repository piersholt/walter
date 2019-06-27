# frozen_string_literal: false

require_relative 'settings/brightness'
require_relative 'settings/date_time'
require_relative 'settings/memo'

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Settings interface controls
          module Settings
            include Brightness
            include DateTime
            include Memo
          end
        end
      end
    end
  end
end
