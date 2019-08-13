# frozen_string_literal: true

require_relative 'api/check_control'
require_relative 'api/ignition'
require_relative 'api/settings'

module Wilhelm
  module Virtual
    class Device
      module IKE
        # Device::IKE::API
        module API
          include CheckControl
          include Ignition
          include Settings
        end
      end
    end
  end
end
