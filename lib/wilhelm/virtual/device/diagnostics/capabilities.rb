# frozen_string_literal: true

require_relative 'capabilities/bmbt'
require_relative 'capabilities/ihka'
require_relative 'capabilities/lcm'
require_relative 'capabilities/gt'
require_relative 'capabilities/radio'
require_relative 'capabilities/zke'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Device::Diagnostics::Capabilities
        module Capabilities
          include BMBT
          include IHKA
          include LCM
          include GT
          include Radio
          include ZKE

          # TODO: module specific methods required
          def hello(ident)
            api_hello(to: ident)
          end
        end
      end
    end
  end
end
