# frozen_string_literal: false

require_relative 'notifications/target'
require_relative 'notifications/player'

module Wilhelm
  module Services
    class Audio
      class Off
        # Audio::Off::Notifications
        module Notifications
          include Target
          include Player
        end
      end
    end
  end
end
