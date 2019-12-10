# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Device::GT::API::Prog
          module Prog
            include Device::API::BaseAPI

            # 0x42 PROG
            def prog(from: :gt, to: :ike, **arguments)
              dispatch_raw_command(from, to, PROG, arguments)
            end
          end
        end
      end
    end
  end
end
