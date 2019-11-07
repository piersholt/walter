# frozen_string_literal: true

require_relative 'api/diagnostics'
require_relative 'api/lamp'

module Wilhelm
  module Virtual
    class Device
      module LCM
        # LCM::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          include Diagnostics
          include Lamp
        end
      end
    end
  end
end
