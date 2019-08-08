# frozen_string_literal: true

module Wilhelm
  module Virtual
    # Virtual::DataParameter
    class DataParameter < BaseParameter
      include Wilhelm::Helpers::PositionalNotation

      attr_reader :multiplier, :label, :suffix

      DEFAULT_MULTIPLIER = 1
      DEFAULT_LABEL = ''
      DEFAULT_SUFFIX = ''

      PROC = 'DataParameter'
      def initialize(configuration, bytes)
        @multiplier = DEFAULT_MULTIPLIER
        @label      = DEFAULT_LABEL
        @suffix     = DEFAULT_SUFFIX
        super(configuration, bytes)
      end

      def inspect
        "<#{PROC} " \
        "@name=#{name} " \
        "@value=#{value} " \
        "@multiplier=#{multiplier} "\
        "@label=#{label} " \
        "@suffix=#{suffix} " \
        "parsed=>#{parsed}>"
      end

      def to_s
        pretty
      end

      def ugly
        "[#{value}]"
      end

      def pretty
        "#{label} #{parsed} #{suffix}"
      end

      def parsed
        @parsed ||= calculated * multiplier
      end

      def calculated
        @calculated ||= base256(*value)
      end

      alias to_sym ugly
    end
  end
end
