# frozen_string_literal: false

require_relative 'controller/constants'

module Wilhelm
  module Services
    class UserInterface
      # Comment
      module Controller
        include Constants
      end
    end
  end
end

require_relative 'controller/manager_controller'
require_relative 'controller/audio_controller'
