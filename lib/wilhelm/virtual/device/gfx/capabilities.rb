# frozen_string_literal: false

require_relative 'capabilities/constants'

require_relative 'capabilities/auxiliary'
require_relative 'capabilities/code'
require_relative 'capabilities/obc'
require_relative 'capabilities/settings'
require_relative 'capabilities/user_controls'
require_relative 'capabilities/user_interface'

module Wilhelm
  module Virtual
    class Device
      module GFX
        # Comment
        module Capabilities
          include Helpers::Button
          include AuxiliaryVentilation
          include Code
          include OnBoardComputer
          include Settings
          include UserControls
          include UserInterface
        end
      end
    end
  end
end
