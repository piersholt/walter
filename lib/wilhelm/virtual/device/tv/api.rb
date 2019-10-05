# frozen_string_literal: true

require_relative 'api/settings'

module Wilhelm
  module Virtual
    class Device
      module TV
        # Top level TV API
        module API
          include Settings
        end
      end
    end
  end
end
