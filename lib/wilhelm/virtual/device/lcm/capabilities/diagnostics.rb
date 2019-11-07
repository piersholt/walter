# frozen_string_literal: true

require_relative 'diagnostics/info'
require_relative 'diagnostics/coding'
require_relative 'diagnostics/status'

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          # LCM::Capabilities::Diagnostics
          module Diagnostics
            include Info
            include Coding
            include Status
          end
        end
      end
    end
  end
end
