# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # GT/Telephone interaction
          module Telephone
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x31 INPUT
            def user_input(from: :gt, to: :rad, **arguments)
              try(from, to, INPUT, arguments)
            end
          end
        end
      end
    end
  end
end
