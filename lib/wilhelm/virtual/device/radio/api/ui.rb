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
            def rad_36(from: :rad, to: :gt, **arguments)
              try(from, to, RAD_EQ, arguments)
            end

            alias rad_eq rad_36

            # 0x37 RAD-ALT
            def rad_37(from: :rad, to: :gt, **arguments)
              try(from, to, RAD_ALT, arguments)
            end

            alias rad_alt rad_37

            # 0x46 MENU-RAD
            def rad_46(from: :rad, to: :gt, **arguments)
              try(from, to, MENU_RAD, arguments)
            end

            alias menu_rad rad_46
          end
        end
      end
    end
  end
end
