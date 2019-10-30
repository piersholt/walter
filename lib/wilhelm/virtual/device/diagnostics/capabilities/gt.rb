# frozen_string_literal: false

require_relative 'gt/coding'
require_relative 'gt/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::GT
          module GT
            include Coding
            include Memory
          end
        end
      end
    end
  end
end
