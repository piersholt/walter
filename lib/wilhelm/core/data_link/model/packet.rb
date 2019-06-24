# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class Packet
      attr_accessor :from, :to, :data

      alias receiver to
      alias sender from

      def initialize(from, to, data)
        @from = from
        @to = to
        @data = data
      end

      def inspect
        "<Packet Tx: #{from} Rx: #{to} Data: #{data}>"
      end

      def to_s
        "#{from}\t#{to}\t#{data}"
      end
    end
  end
end
