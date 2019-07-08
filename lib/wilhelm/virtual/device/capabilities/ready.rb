# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Capabilities
        # Device::Capabilities::Ready
        module Ready
          include API::Readiness

          REPLY = 0x00
          ANNOUNCE = 0x01

          # Request
          def ping(to)
            p1ng(from: me, to: to)
          end

          # Reply
          def pong(to: :glo_l)
            p0ng(from: me, to: to, status: REPLY)
          end

          # Broadcast
          def announce
            return false if announced?
            p0ng(from: me, status: ANNOUNCE)
            announced!
          end

          # Force announce...
          def announce!
            p0ng(from: me, status: ANNOUNCE)
            announced!
          end

          private

          def announced?
            announced
          end

          def announced!
            @announced = true
          end

          def announced
            @announced ||= false
          end
        end
      end
    end
  end
end
