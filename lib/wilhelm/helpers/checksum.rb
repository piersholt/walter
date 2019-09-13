# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Checksum
    module Checksum
      include DataTools
      include Bitwise

      NAME = 'Checksum'.freeze
      SPACE = ' '.freeze

      def parity(*bytes)
        xor(*bytes)
      end

      def parity?(*bytes, checksum)
        xor(*bytes) == checksum
      end

      def pretty_parity?(*bytes, checksum)
        LOGGER.debug(NAME) { "#pretty_parity?(#{bytes}, #{checksum})" }
        if bytes.any? { |b| b.is_a?(String) } || checksum.is_a?(String)
          bytes = s2i(checksum)[0..-2]
          checksum = s2i(checksum)[-1]
        end
        LOGGER.info(NAME) do
          "#{i2s(*bytes)} " \
          "[#{i2s(checksum)}] " \
          "== #{i2s(parity(*bytes))} " \
          "=> #{parity?(*bytes, checksum)}"
        end
        parity?(*bytes, checksum)
      end

      alias pp? pretty_parity?

      # @param String string "C8 04 BF 02 38 49"
      # Valid hex representations: C8, 0xC8, C8H
      # @return Array<Integer> [0xC8, 0x04, 0xBF, 0x02, 0x38, 0x49]
      def hex_string_to_ints(string)
        validate_string(string)
        string.split.map { |c| c.to_i(16) }
      end

      alias s2i hex_string_to_ints

      # @param Array<Integer> ints [0xC8, 0x04, 0xBF, 0x02, 0x38, 0x49]
      # Valid hex representations: C8, 0xC8, C8H
      # @return String "C8 04 BF 02 38 49"
      def ints_to_hex_string(*ints)
        validate_ints(*ints)
        ints.map { |i| d2h(i) }&.join(SPACE)
      end

      alias i2s ints_to_hex_string

      private

      def validate_string(string)
        return true if string.is_a?(String)
        raise(ArgumentError, "Input is not String! #{string}")
      end

      def validate_ints(*ints)
        return true if ints.all? { |i| i.is_a?(Integer) }
        raise(ArgumentError, "Input(s) are not Integer! (#{ints})")
      end
    end
  end
end
