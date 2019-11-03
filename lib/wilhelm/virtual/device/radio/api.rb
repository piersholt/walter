# frozen_string_literal: true

require_relative 'api/display'
require_relative 'api/diagnostics'
require_relative 'api/led'
require_relative 'api/tmc'

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

          # CD CHANGER

          # 0x38
          def cd_changer_request(from: :rad, to: :cdc, arguments:)
            try(from, to, CDC_REQ, arguments)
          end

          # MENU/USER INTERFACE

          # 0x46 MENU-RAD
          def menu_rad(from: :rad, to: :gt, arguments:)
            try(from, to, MENU_RAD, arguments)
          end

          # 0x37 RAD-ALT
          def rad_alt(from: :rad, to: :gt, **arguments)
            try(from, to, RAD_ALT, arguments)
          end
        end
      end
    end
  end
end
