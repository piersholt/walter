# frozen_string_literal: true

require_relative 'capabilities/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module EHC
        # Device::EHC::Capabilities
        module Capabilities
          include Diagnostics::Info

          def ehc_ready!(data = [0x01])
            ehc_ready(arguments: data)
          end
        end
      end
    end
  end
end
