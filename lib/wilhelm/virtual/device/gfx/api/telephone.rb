# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GFX
        module API
          # GFX/Telephone interaction
          module Telephone
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x31 TEL_DATA
            def user_input(from: :gfx, to: :rad, **arguments)
              try(from, to, TEL_DATA, arguments)
            end
          end
        end
      end
    end
  end
end
