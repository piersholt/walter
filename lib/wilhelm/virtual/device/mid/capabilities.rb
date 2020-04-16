# frozen_string_literal: false

require_relative 'capabilities/ui'

module Wilhelm
  module Virtual
    class Device
      module MID
        # Device::MID::Capabilities
        module Capabilities
          include UI
        end
      end
    end
  end
end
