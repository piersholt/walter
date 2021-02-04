# frozen_string_literal: true

require_relative 'service/constants'
require_relative 'service/display'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Radio::Capabilities::Service
          module Service
            include Display
          end
        end
      end
    end
  end
end
