# frozen_string_literal: true

module Wilhelm
  class Virtual
    module Capabilities
      # Comment
      module CDChanger
        include Wilhelm::Virtual::API::CDChanger
        include Helpers
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
