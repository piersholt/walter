# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Virtual::DataAdapter
    class DataAdapter
      def self.adapt(data_object)
        DataAdapter.new(data_object)
      end

      def initialize(data_object)
        @data_object = data_object
      end

      def from
        @data_object.from
      end

      def to
        @data_object.to
      end

      def payload
        @data_object.payload
      end

      def command
        payload[0]
      end

      def arguments
        payload[1..-1]
      end

      def to_s
        "#{from}\t#{to}\t[#{command}]\t#{arguments}"
      end
    end
  end
end
