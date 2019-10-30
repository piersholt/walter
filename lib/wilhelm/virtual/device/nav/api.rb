# frozen_string_literal: true

require_relative 'api/assist'

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Navigation::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          include Assist
          include Diagnostics
        end
      end
    end
  end
end
