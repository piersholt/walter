# frozen_string_literal: false

require_relative 'on/actions'
require_relative 'on/states'

module Wilhelm
  module Services
    class Audio
      # Audio::On
      class On
        include Logging
        include Defaults
        include States
        include Actions

        def initialize(*)
          logger.debug(AUDIO_ON) { '#initialize' }
        end
      end
    end
  end
end
