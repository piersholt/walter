# frozen_string_literal: true

require_relative 'capabilities/auxiliary'
require_relative 'capabilities/check_control'
require_relative 'capabilities/ignition'
require_relative 'capabilities/region'
require_relative 'capabilities/settings'

module Wilhelm
  module Virtual
    class Device
      module IKE
        # OBC, Set, and Aux. Vent/Heat Control
        module Capabilities
          include AuxiliaryVentilation
          include CheckControl
          include Ignition
          include Region
          include Settings
        end
      end
    end
  end
end
