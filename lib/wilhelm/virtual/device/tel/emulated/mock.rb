# frozen_string_literal: true

require_relative 'mock/info'
require_relative 'mock/pin'
require_relative 'mock/quick'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Mock
          module Mock
            include Info
            include PIN
            include Quick
          end
        end
      end
    end
  end
end
