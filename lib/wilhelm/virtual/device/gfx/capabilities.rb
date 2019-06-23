# frozen_string_literal: false

require_relative 'capabilities/constants'
require_relative 'capabilities/user_interface'
require_relative 'capabilities/user_controls'
require_relative 'capabilities/obc'
require_relative 'capabilities/lcd'

module Wilhelm
  module Virtual
    class Device
      module GFX
        # Comment
        module Capabilities
          include Helpers::Button
          include UserInterface
          include UserControls
          include OBC
          include LCD
        end
      end
    end
  end
end
