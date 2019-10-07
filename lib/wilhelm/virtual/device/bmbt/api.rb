# frozen_string_literal: true

require_relative 'api/controls'
require_relative 'api/diagnostics'
require_relative 'api/settings'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # API for command related to keys
        module API
          include Controls
          include Diagnostics
          include Settings
        end
      end
    end
  end
end
