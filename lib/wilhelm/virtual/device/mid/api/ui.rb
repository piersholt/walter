# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MID
        module API
          # MID::API::UI
          module UI
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x20 MID-REQ
            def ui_request(from: :mid, to: :glo_h, **arguments)
              try(from, to, TEL_OPEN, arguments)
            end

            # 0x31 SOFT-INPUT
            # @param Integer layout
            # @param Integer function
            # @param Integer button
            def soft_input(from: :mid, to: :ike, **arguments)
              try(from, to, INPUT, arguments)
            end
          end
        end
      end
    end
  end
end
