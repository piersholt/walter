# frozen_string_literal: true

require_relative 'api/controls'
require_relative 'api/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # API for command related to keys
        module API
          include Controls
          include Diagnostics
        end
      end
    end
  end
end
