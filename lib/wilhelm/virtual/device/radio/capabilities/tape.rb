# frozen_string_literal: true

require_relative 'tape/constants'
require_relative 'tape/display'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Tape
          module Tape
            include Display
          end
        end
      end
    end
  end
end
