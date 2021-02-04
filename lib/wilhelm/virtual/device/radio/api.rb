# frozen_string_literal: true

require_relative 'api/cdc'
require_relative 'api/display'
require_relative 'api/diagnostics'
require_relative 'api/led'
require_relative 'api/tmc'
require_relative 'api/ui'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Radio::API
        module API
          include Device::API::BaseAPI
          include Display
          include CDC
          include LED
          include Diagnostics
          include TMC
          include UserInterface
        end
      end
    end
  end
end
