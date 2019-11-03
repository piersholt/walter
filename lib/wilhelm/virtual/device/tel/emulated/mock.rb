# frozen_string_literal: true

require_relative 'mock/quick'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Mock
          module Mock
            include Quick
          end
        end
      end
    end
  end
end
