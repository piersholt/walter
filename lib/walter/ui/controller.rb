# frozen_string_literal: false

require_relative 'controller/constants'

class Walter
  class UserInterface
    # Comment
    module Controller
      include Constants
    end
  end
end

require_relative 'controller/bluetooth_controller'
require_relative 'controller/audio_controller'
