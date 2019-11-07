# frozen_string_literal: true

require_relative 'capabilities/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Navigation::Capabilities
        module Capabilities
          include Diagnostics
        end
      end
    end
  end
end
