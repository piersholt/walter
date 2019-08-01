# frozen_string_literal: false

module Wilhelm
  module Core
    # Wilhelm::Core::Data
    # Interim data structure pre virtual routing
    class Data
      attr_accessor :from, :to, :payload

      alias sender from
      alias receiver to

      def initialize(from, to, payload)
        @from = from
        @to = to
        @payload = payload
      end

      def inspect
        "<Data Tx: #{from} Rx: #{to} Payload: #{payload}>"
      end

      def to_s
        "#{from}\t#{to}\t#{payload}"
      end
    end
  end
end
