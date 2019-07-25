# frozen_string_literal: true

require_relative 'ui/view/now_playing'
require_relative 'ui/view/targets'
require_relative 'ui/view/index'
require_relative 'ui/view/header/audio'
require_relative 'ui/controller/audio_controller'

module Wilhelm
  module Services
    class Manager
      class UserInterface
        module Controller
          class ManagerController < SDK::UIKit::Controller::BaseController
            LOGGER = LogActually.services
          end
        end
      end
    end
  end
end
