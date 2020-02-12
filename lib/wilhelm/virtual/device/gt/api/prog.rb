# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Device::GT::API::Prog
          module Prog
            include Device::API::BaseAPI

            DEFAULT = [
              0x01, 0x02, 0x04, 0x05,
              0x06, 0x07, 0x08, 0x09,
              0x0a, 0x0e, 0x0f, 0x10
            ].freeze

            # 0x42 PROG
            def prog(from: :gt, to: :ike, **arguments)
              dispatch_raw_command(from, to, PROG, arguments)
            end

            def prog!(*functions)
              return false if functions.size > 12
              functions = DEFAULT if functions.empty?
              functions << 0xff while functions.size < 12
              prog(functions: functions)
            end
          end
        end
      end
    end
  end
end
