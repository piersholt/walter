# frozen_string_literal: true

require_relative 'analogue/constants'
require_relative 'analogue/display'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Analogue Radio
          module Analogue
            include Display
          end
        end
      end
    end
  end
end
