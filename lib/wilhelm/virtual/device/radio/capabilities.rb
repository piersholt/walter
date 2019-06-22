# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/cd_changer_control'
require_relative 'capabilities/cd_changer_display'
require_relative 'capabilities/radio_display'
require_relative 'capabilities/rds_display'
require_relative 'capabilities/user_interface'
require_relative 'capabilities/led'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Comment
        module Capabilities
          include Helpers::Button
          include Helpers::Data
          include UserInterface
          include CDChangerControl
          include CDChangerDisplay
          include RDSDisplay
          include LED
        end
      end
    end
  end
end
