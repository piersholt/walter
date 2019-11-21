# frozen_string_literal: true

require_relative 'ui/constants'
require_relative 'ui/config'
require_relative 'ui/select'
require_relative 'ui/tone'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # Radio::Capabilities::UserInterface
          module UserInterface
            include Config
            include Select
            include Tone
          end
        end
      end
    end
  end
end
