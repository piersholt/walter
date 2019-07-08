# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        # LCM::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def odometer_reqest(from: :lcm, to: :ike, arguments: [])
            try(from, to, ODO_REQ, arguments)
          end
        end
      end
    end
  end
end
