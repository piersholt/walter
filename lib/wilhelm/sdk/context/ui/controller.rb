# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Controller
          LOGGER = LogActually.sdk
        end
      end
    end
  end
end

puts "\tLoading wilhelm/sdk/context/ui/controller"
require_relative 'controller/encoding_controller'
require_relative 'controller/debug_controller'
require_relative 'controller/header_controller'
require_relative 'controller/services_controller'
