# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Capabilities
      # Comment
      module Ready
        include Wilhelm::Virtual::API::Readiness

        # Request
        def ping(to)
          p1ng(from: me, to: to)
        end

        # Reply
        def pong(to: :glo_l)
          p0ng(from: me, to: to, status: 0x00)
        end

        # Broadcast
        def announce
          return false if announced?
          p0ng(from: me, status: 0x01)
          announced!
        end

        def announce!
          p0ng(from: me, status: 0x01)
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
