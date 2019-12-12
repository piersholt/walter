# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Capabilities
        # Device::Capabilities::Ready
        module Ready
          include API::Readiness

          DEFAULT_PRIORITY  = :glo_l
          DEFAULT_IDENT     = 0b0000_0000
          ANNOUNCE          = 0b0000_0001

          # Request
          def ping(to)
            p1ng(from: me, to: to)
          end

          # Reply
          def pong(to: DEFAULT_PRIORITY, status: DEFAULT_IDENT)
            p0ng(from: me, to: to, status: status)
          end

          # Broadcast
          def announce(to: DEFAULT_PRIORITY, status: DEFAULT_IDENT | ANNOUNCE)
            return false if announced?
            p0ng(from: me, to: to, status: status)
            announced!
          end

          def announce!(to: DEFAULT_PRIORITY, status: DEFAULT_IDENT | ANNOUNCE)
            p0ng(from: me, to: to, status: status)
            announced!
          end

          private

          def announced?
            @announced ||= false
          end

          def announced!
            @announced = true
          end

          def unannounce!
            @announced = false
          end
        end
      end
    end
  end
end
