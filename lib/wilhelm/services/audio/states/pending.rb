# frozen_string_literal: false

require_relative 'pending/states'

module Wilhelm
  module Services
    class Audio
      # Audio::Pending
      class Pending
        include Logging
        include Defaults
        include States

        def initialize(context)
          logger.debug(AUDIO_PENDING) { '#initialize' }
          # Note: this is a request
          context.targets?
          context.register_controls(Wilhelm::API::Controls.instance)
        end
      end
    end
  end
end
