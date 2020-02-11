# frozen_string_literal: false

require_relative 'zke/activate'
require_relative 'zke/coding'
require_relative 'zke/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Central Body Electronics (ZKE)
          module ZKE
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
