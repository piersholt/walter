# frozen_string_literal: true

require_relative 'capabilities/bmbt'
require_relative 'capabilities/gm'
require_relative 'capabilities/lcm'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Device::Diagnostics::Capabilities
        module Capabilities
          include BMBT
          include GM
          include LCM

          # TODO: module specific methods required
          def hello(ident)
            api_hello(to: ident)
          end
        end
      end
    end
  end
end
