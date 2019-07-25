# frozen_string_literal: false

require_relative 'disabled/states'

module Wilhelm
  module Services
    class Audio
      # Audio::Disabled
      class Disabled
        include Logging
        include Defaults
        include States
      end
    end
  end
end
