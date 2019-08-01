# frozen_string_literal: true

require_relative 'api/display'
require_relative 'api/status'
require_relative 'api/led'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Telephone::API
        module API
          include Display
          include Status
          include LED
        end
      end
    end
  end
end
