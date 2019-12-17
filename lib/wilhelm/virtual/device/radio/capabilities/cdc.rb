# frozen_string_literal: true

require_relative 'cdc/constants'
require_relative 'cdc/display'
require_relative 'cdc/playback'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # CD Changer
          module CDChanger
            include Display
            include Playback
          end
        end
      end
    end
  end
end
