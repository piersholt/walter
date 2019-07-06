# frozen_string_literal: false

require_relative 'off/actions'
require_relative 'off/notifications'
require_relative 'off/states'

module Wilhelm
  module Services
    class Audio
      # Audio::On
      class Off
        include Logging
        include Defaults
        include States
        include Actions
        include Notifications

        def initialize(*)
          logger.debug(AUDIO_OFF) { '#initialize' }
        end
      end
    end
  end
end