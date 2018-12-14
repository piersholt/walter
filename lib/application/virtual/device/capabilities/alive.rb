# frozen_string_literal: true

module Capabilities
  # Comment
  module Alive
    include API::Alive

    # Request
    def ping(to:)
      p1ng(from: me, to: to)
    end

    # Broadcast
    def ann0unce(from: me)
      return false if announced
      p0ng(from: from, status: 0x01)
    end

    # Reply
    def pong(from: me); end

    def announced?
      announced
    end

    private

    def announced!
      @announced = true
    end

    def announced
      @announced ||= false
    end
  end
end
