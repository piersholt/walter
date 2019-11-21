# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module API
          # Device::Radio::API::UI
          module UserInterface
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x36 RAD-EQ
            def rad_eq(from: :rad, to: :gt, **arguments)
              try(from, to, RAD_EQ, arguments)
            end

            # 0x37 RAD-ALT
            def rad_alt(from: :rad, to: :gt, **arguments)
              try(from, to, RAD_ALT, arguments)
            end

            # 0x46 MENU-RAD
            def menu_rad(from: :rad, to: :gt, **arguments)
              try(from, to, MENU_RAD, arguments)
            end
          end
        end
      end
    end
  end
end
