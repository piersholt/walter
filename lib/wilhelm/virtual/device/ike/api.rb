# frozen_string_literal: true

require_relative 'api/check_control'
require_relative 'api/ignition'
require_relative 'api/prog'
require_relative 'api/redundant'
require_relative 'api/region'
require_relative 'api/settings'
require_relative 'api/sensors'
require_relative 'api/temperature'
require_relative 'api/speed'

module Wilhelm
  module Virtual
    class Device
      module IKE
        # Device::IKE::API
        module API
          include CheckControl
          include Ignition
          include Prog
          include Redundant
          include Region
          include Sensors
          include Settings
          include Speed
          include Temperature
        end
      end
    end
  end
end
