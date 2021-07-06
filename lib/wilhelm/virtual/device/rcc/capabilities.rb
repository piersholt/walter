# frozen_string_literal: true

require_relative 'capabilities/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module RadioControlledClock
        # Device::RadioControlledClock::Capabilities
        module Capabilities
          include Diagnostics::Info
        end
      end
    end
  end
end
