# frozen_string_literal: true

require_relative 'capabilities/constants'
require_relative 'capabilities/chainable'
require_relative 'capabilities/state'

module Wilhelm
  module Virtual
    class Device
      module CDC
        # Device::CDC::Capabilities
        module Capabilities
          include API
          include Helpers::Data
          include State

          def done
            send_status(current_state)
          end

          def c(integer)
            state!(control: integer)
          end

          def cl
            (0x00..0xFF).each do |i|
              c(i)
              done
              Kernel.sleep(1)
            end
          end

          def send_status(current_state)
            cd_changer_status(from: me, to: :rad, arguments: current_state)
          end
        end
      end
    end
  end
end
