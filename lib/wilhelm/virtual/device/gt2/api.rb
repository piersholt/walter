# frozen_string_literal: true

require_relative 'api/menu'

module Wilhelm
  module Virtual
    class Device
      module GT2
        # GT2::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          include Menu
        end
      end
    end
  end
end
