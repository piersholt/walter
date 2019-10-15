# frozen_string_literal: true

require_relative 'capabilities/gm'
require_relative 'capabilities/lcm'
require_relative 'capabilities/bmbt'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Device::Diagnostics::Capabilities
        module Capabilities
          include GM
          include BMBT
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
