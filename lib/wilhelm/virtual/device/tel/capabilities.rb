# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/dial'
require_relative 'capabilities/directory'
require_relative 'capabilities/info'
require_relative 'capabilities/last_numbers'
require_relative 'capabilities/led'
require_relative 'capabilities/pin'
require_relative 'capabilities/sos'
require_relative 'capabilities/top_8'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Device::Telephone::Capabilities
        module Capabilities
          include Helpers
          include Constants
          include Dial
          include Directory
          include Info
          include LastNumbers
          include LED
          include Top8
          include SOS
          include PIN

          def set_status(bit_array)
            status(status: bit_array)
          end
        end
      end
    end
  end
end
