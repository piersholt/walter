# frozen_string_literal: true

require_relative 'api/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module RadioControlledClock
        # RadioControlledClock::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          include Diagnostics
        end
      end
    end
  end
end
