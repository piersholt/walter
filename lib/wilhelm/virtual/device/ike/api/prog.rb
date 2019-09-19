# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # Device::IKE::API::Prog
          module Prog
            include Device::API::BaseAPI

            # 0x42 PROG
            def prog(from: :ike, to: :gfx, **arguments)
              dispatch_raw_command(from, to, PROG, arguments)
            end
          end
        end
      end
    end
  end
end
