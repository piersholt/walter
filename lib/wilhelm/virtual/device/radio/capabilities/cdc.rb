# frozen_string_literal: true

require_relative 'cdc/display'
require_relative 'cdc/playback'
require_relative 'cdc/select'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # CD Changer
          module CDChanger
            include Playback
            include Select
            include Display
          end
        end
      end
    end
  end
end
