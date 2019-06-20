# frozen_string_literal: false

module Wilhelm
  module Core
    class CharsParameter < BaseParameter
      PROC = 'CharsParameter'.freeze

      attr_reader :chars

      def initialize(configuration, char_array)
        super(configuration, char_array)
        @raw = char_array
        format_char_array
      end

      def format_char_array
        LOGGER.warn(PROC) { "Cannot create @chars without value. Value = #{value}" } if value.nil?
        @chars = Command::Chars.new(value, true)
      end

      def to_s
        "#{value} (#{@chars})"
      end

      def inspect
        "<#{PROC} @value=#{value} @chars=#{chars}>"
      end

      def empty?
        chars.char.nil?
      end

      def length
        chars.char.length
      end

      def raw
        @raw
        chars.to_s
      end

      def to_s
        "\"#{chars}\""
      end
    end
  end
end
