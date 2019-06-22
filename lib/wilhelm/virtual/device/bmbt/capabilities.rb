# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/user_controls'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # Comment
        module Capabilities
          include Helpers
          include UserControls
        end
      end
    end
  end
end
