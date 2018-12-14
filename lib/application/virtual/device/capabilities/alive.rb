# frozen_string_literal: true

module Capabilities
  # Comment
  module Alive
    include API::Alive

    # Request
    def ping(to)
      p1ng(from: me, to: to)
    end

    # Reply
    def pong(to)
      p0ng(from: me, to: to, status: 0x00)
    end

    # Broadcast
    def ann0unce
      return false if announced?
      p0ng(from: from, status: 0x01)
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
