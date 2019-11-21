# frozen_string_literal: true

require_relative 'api/controls'
require_relative 'api/diagnostics'
require_relative 'api/monitor'
require_relative 'api/radio'
require_relative 'api/settings'

module Wilhelm
  module Virtual
    class Device
      module GT
        # Top level GT API
        module API
          include Controls
          include Diagnostics
          include Monitor
          include Radio
          include Settings
        end
      end
    end
  end
end
