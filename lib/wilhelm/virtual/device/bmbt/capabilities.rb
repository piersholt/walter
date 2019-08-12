# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/diagnostics'
require_relative 'capabilities/user_controls'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # BMBT::Capabilities
        module Capabilities
          include Helpers::Button
          include UserControls
          include Diagnostics
        end
      end
    end
  end
end
