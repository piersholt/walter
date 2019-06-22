# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/buttons'

module Wilhelm
  module Virtual
    class Device
      module MFL
        # Comment
        module Capabilities
          include Helpers
          include Buttons
        end
      end
    end
  end
end
