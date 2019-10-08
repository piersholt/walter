# frozen_string_literal: false

require_relative 'settings/brightness'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # Settings interface controls
          module Settings
            include Brightness
          end
        end
      end
    end
  end
end
