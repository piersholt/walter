# frozen_string_literal: true

module Wilhelm
  module Virtual
    # this should have the map
    # if you change the value, you shouldn't need to also set the display value etc
    # it will need to be an instance variable
    class BaseParameter
      include Helpers
      include Wilhelm::Helpers::DataTools

      DEFAULT_LABEL_WIDTH = 0
      LABEL_DELIMITER = ': '
      PROC = 'CommandParam'

      attr_reader :value, :name

      def initialize(configuration, value)
        configuration.configure(self)
        @value = value
      end

      def inspect
        "<#{PROC} @name=#{name} @value=#{value}>"
      end

      def to_s
        "#{name}: \"#{value}\""
      end
    end
  end
end
