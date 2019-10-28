# frozen_string_literal: true

require_relative 'api/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module Navigation
        # Top level Navigation API
        module API
          include Diagnostics
        end
      end
    end
  end
end
