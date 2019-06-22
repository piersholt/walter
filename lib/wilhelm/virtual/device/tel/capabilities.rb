# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/directory'
require_relative 'capabilities/info'
require_relative 'capabilities/led'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Comment
        module Capabilities
          include Constants
          include Helpers
          include Virtual::Capabilities::Ready
          include LED
          include Directory
          include Info

          def logger
            LOGGER
          end

          def set_status(bit_array)
            status(status: bit_array)
          end
        end
      end
    end
  end
end
