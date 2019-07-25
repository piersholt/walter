# frozen_string_literal: false

require_relative 'off/actions'
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

        def initialize(context)
          logger.debug(AUDIO_OFF) { '#initialize' }
          # Note: this is a request
          context.player?(context.targets.selected_target&.player)
        end
      end
    end
  end
end
