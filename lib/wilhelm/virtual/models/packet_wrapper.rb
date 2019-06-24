# frozen_string_literal: false

module Wilhelm
  module Virtual
    class PacketWrapper
      extend Forwardable

      def_delegators :@packet, :to, :from, :data

      def self.wrap(packet)
        PacketWrapper.new(packet)
      end

      def initialize(packet)
        @packet = packet
      end

      def command
        data = @packet.data
        data[0]
      end

      def arguments
        data = @packet.data
        data[1..-1]
      end

      def to_s
        "#{from} >\t[#{command}]\t#{arguments}"
      end
    end
  end
end
