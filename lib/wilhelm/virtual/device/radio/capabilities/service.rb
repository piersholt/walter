# frozen_string_literal: true

# require_relative 'analogue/display'

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
