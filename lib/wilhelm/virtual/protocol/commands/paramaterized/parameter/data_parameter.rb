# frozen_string_literal: true

module Wilhelm
  module Virtual
    class DataParameter < BaseParameter
      include Wilhelm::Helpers::PositionalNotation

      PROC = 'DataParameter'
      def initialize(configuration, bytes)
        LOGGER.unknown(PROC) { bytes }
        super(configuration, bytes)
      end

      def inspect
        "<#{PROC} @value=#{value}>"
      end

      def to_s
        pretty
      end

      def ugly
        "[#{base256(*value)}]"
      end

      def pretty
        "Fixnum: #{base256(*value)}"
      end

      alias to_sym ugly
    end
  end
end
