# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module API
          # LCM::API::Lamp
          module Lamp
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            def lamp(from: :lcm, to: :glo_l, **arguments)
              try(from, to, LAMP_REP, arguments)
            end

            def lamp!(l1, l2, l3, l4)
              lamp(l1: l1, l2: l2, l3: l3, l4: l4)
            end
          end
        end
      end
    end
  end
end
