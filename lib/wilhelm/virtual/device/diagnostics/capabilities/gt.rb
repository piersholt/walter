# frozen_string_literal: false

require_relative 'gt/constants'
require_relative 'gt/coding'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::GT
          module GT
            include Coding
          end
        end
      end
    end
  end
end
