# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/analogue'
require_relative 'capabilities/cdc'
require_relative 'capabilities/digital'
require_relative 'capabilities/led'
require_relative 'capabilities/user_interface'
require_relative 'capabilities/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Device::Radio::Capabilities
        module Capabilities
          include Helpers::Button
          include Helpers::Data
          include Analogue
          include CDChanger
          include RDS
          include LED
          include UserInterface
          include Diagnostics
        end
      end
    end
  end
end
