# frozen_string_literal: false

require_relative 'disabled/notifications'
require_relative 'disabled/states'

module Wilhelm
  module Services
    class Audio
      # Audio::Disabled
      class Disabled
        include Logging
        include Defaults
        include States
        include Notifications
      end
    end
  end
end
