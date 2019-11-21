# frozen_string_literal: true

require_relative 'api/display'
require_relative 'api/diagnostics'
require_relative 'api/led'
require_relative 'api/tmc'
require_relative 'api/ui'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Radio::API
        module API
          include Device::API::BaseAPI
          include Display
          include LED
          include Diagnostics
          include TMC
          include UserInterface

          # CD CHANGER

          # 0x38
          def cd_changer_request(from: :rad, to: :cdc, arguments:)
            try(from, to, CDC_REQ, arguments)
          end
        end
      end
    end
  end
end
