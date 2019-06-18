# frozen_string_literal: false

require_relative 'view/constants'

module Wilhelm
  class UserInterface
    # Comment
    module View
      include Constants
    end
  end
end

require_relative 'view/header/audio'

require_relative 'view/bluetooth/device'
require_relative 'view/bluetooth/index'

require_relative 'view/audio/now_playing'
require_relative 'view/audio/index'
