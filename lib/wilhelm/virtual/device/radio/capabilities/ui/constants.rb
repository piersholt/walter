# frozen_string_literal: true

require_relative 'constants/config'
require_relative 'constants/eq'
require_relative 'constants/tone_select'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            # Radio::Capabilities::UserInterface::Constants
            module Constants
              include Config
              include EQ
              include ToneSelect
            end
          end
        end
      end
    end
  end
end
