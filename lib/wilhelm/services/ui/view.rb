# frozen_string_literal: false

require_relative 'view/constants'

module Wilhelm
  module Services
    class UserInterface
      # Comment
      module View
        include Constants
      end
    end
  end
end

require_relative 'view/header/audio'

require_relative 'view/manager/device'
require_relative 'view/manager/index'

require_relative 'view/audio/now_playing'
require_relative 'view/audio/index'
