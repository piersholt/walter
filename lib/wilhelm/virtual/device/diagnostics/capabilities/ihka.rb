# frozen_string_literal: false

# require_relative 'ihka/activate'
# require_relative 'ihka/coding'
require_relative 'ihka/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::IHKA::Activate
          module IHKA
            include Memory
          end
        end
      end
    end
  end
end
