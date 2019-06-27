# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        # Comment
        module Capabilities
          include API
          include Helpers::Data

          # OBC
          def obc_bool(byte_one, byte_two)
            api_2a(control: byte_one, unconfirmed: byte_two)
          end

          def obc_var(gfx, ike, chars = genc(6).bytes)
            api_24(gfx: gfx, ike: ike, chars: chars)
          end
        end
      end
    end
  end
end
