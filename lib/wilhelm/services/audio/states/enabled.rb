# frozen_string_literal: false

require_relative 'enabled/states'

module Wilhelm
  module Services
    class Audio
      # Audio::Enabled
      class Enabled
        include Logging
        include Defaults
        include States

        def initialize(context)
          logger.debug(AUDIO_ENABLED) { '#initialize' }
          # Note: this is a request
          context.targets?
          context.register_controls(Wilhelm::API::Controls.instance)
        end
      end
    end
  end
end
