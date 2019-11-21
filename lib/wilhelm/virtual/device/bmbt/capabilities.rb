# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/diagnostics'
require_relative 'capabilities/settings'
require_relative 'capabilities/controls'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # BMBT::Capabilities
        module Capabilities
          include Helpers::Button
          include Settings
          include Controls
          include Diagnostics
        end
      end
    end
  end
end
