# frozen_string_literal: false

require_relative 'gm/activate'
require_relative 'gm/coding'
require_relative 'gm/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::GM
          module GM
            include Helpers::Data
            include API

            include Activate
            include Coding
            include Memory
          end
        end
      end
    end
  end
end
