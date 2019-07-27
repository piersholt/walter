# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Helpers::DataTools
    module DataTools
      extend self

      MOD_PROC = 'DataTools'.freeze

      hex09 = ('0'..'9').to_a
      hex_af = ('A'..'F').to_a

      HEX = (hex09 + hex_af).freeze
      BINARY_ENCODING = Encoding::ASCII_8BIT

      FORMATS = %i[encoded hex decimal binary].freeze
      FORMAT_ALIASES = {
        e: :encoded,
        enc: :encoded,
        h: :hex,
        d: :decimal,
        dec: :decimal,
        bin: :binary,
        b: :binary
      }.freeze

      MASK_DECIMAL      = '%#.d'.freeze
      MASK_HEX          = '%.8b'.freeze
      MASK_HEX_PREFIXED = '%#.8b'.freeze

      WIDTH     = 10
      SPACE     = ' '.freeze
      DELIMITER = '-'.freeze
      BLANK     = ''.freeze
      ASTERISK  = '*'.freeze
      PERIOD    = '.'.freeze

      def common(*numbers)
        numbers = numbers.dup

        header = Array.new(8) { |x| 7 - x }.join(SPACE)

        puts DELIMITER.center(WIDTH) + header
        puts DELIMITER.center(WIDTH) + Array.new(header.length, DELIMITER).join(BLANK)
        numbers.map! do |each_number|
          binary_string = Kernel.format('%.8b', each_number)
          bits_array = binary_string.split(BLANK)
          puts each_number.to_s.center(WIDTH) + bits_array.join(SPACE).to_s
          bits_array.reverse!
          bits_array.map!(&:to_i)
        end

        bit_positions = numbers.transpose
        result = bit_positions.find_index do |pos|
          if pos.include?(0)
            false
          elsif pos.minmax.first == pos.minmax.last
            true
          end
        end

        raise RangeError, 'No common bits!' unless result

        footer = Array.new(8, PERIOD)
        footer[-1] = ASTERISK
        output = DELIMITER.center(WIDTH) + footer.join(PERIOD)
        puts output

        puts "Position of common bit: #{result}"

        result
      end

      # ------------------------ CHECKSUM ------------------------ #

      def fcs(*integers)
        integers.reduce(0) do |c, d|
          c ^ d
        end
      end

      # ------------------------ HEX TO X ------------------------ #

      def hex_to_encoded(hex_value)
        hex_value.hex.chr(BINARY_ENCODING)
      end

      def hex_to_decimal(hex_value)
        hex_value.hex
      end

      alias h2d hex_to_decimal

      def hex_to_binary(hex, nibbles = false, prefix = false)
        hex = hex.to_s
        decimal_to_binary(hex.hex, nibbles, prefix)
      end

      alias h2b hex_to_binary

      # ------------------------ DECIMAL TO X ------------------------ #

      # @alias
      def d2h(decimal, prefix = false)
        decimal_to_hex(decimal, prefix)
      end

      def decimal_to_hex(decimal, prefix = false)
        raise EncodingError, 'nil byte...?' if decimal.nil?
        mask = prefix ? '%#.2x' : '%.2X'
        Kernel.format(mask, decimal)
      end

      def decimal_to_binary(decimal, nibbles = false, prefix = false)
        to_binary(decimal, nibbles, prefix)
      end

      def d2b(decimal, nibbles = false, prefix = false)
        decimal_to_binary(decimal, nibbles, prefix)
      end

      # ------------------------ BINARY TO X ------------------------ #

      # @alias
      def b2d(input_value)
        binary_to_decimal(input_value)
      end

      def binary_to_decimal(input_value)
        Kernel.format(MASK_DECIMAL, input_value)
      end

      # ------------------------ ENC TO X ------------------------ #

      ERROR_CHAR_LENGTH = 'Character length is greater than one byte!'.freeze

      def encoded_to_decimal(char)
        raise EncodingError, ERROR_CHAR_LENGTH if char.length > 1
        char.getbyte(0)
      end

      def encoded_to_hex(value)
        decimal = encoded_to_decimal(value)
        decimal_to_hex(decimal)
      end

      # @private

      def to_binary(input_value, nibbles = false, prefix = false)
        # prefix 0b
        mask = prefix ? MASK_HEX_PREFIXED : MASK_HEX
        str_buffer = Kernel.format(mask, input_value)
        # nibbles
        if nibbles && !prefix
          index = prefix ? 6 : 4
          str_buffer = str_buffer.insert(index, ' ')
        end
        str_buffer
      end

      # @deprecated
      def base16(num, output = [])
        nibble = num.modulo(16)
        num -= nibble
        num = num.div(16)

        output.unshift(HEX[nibble])
        base16(num, output) if num.positive?
        return *output
      end
    end
  end
end
