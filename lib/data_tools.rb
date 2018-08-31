module DataTools
  extend self

  HEX = (0..9).map { |i| i.to_s } + ('A'..'F').map {|c| c}
  BINARY_ENCODING = Encoding::ASCII_8BIT

  FORMATS = [:encoded, :hex, :decimal, :binary]
  FORMAT_ALIASES = {
    :e =>:encoded,
    :enc =>:encoded,
    :h =>:hex,
    :d =>:decimal,
    :dec =>:decimal,
    :bin =>:binary,
    :b =>:binary }

  # ------------------------ CHECKSUM ------------------------ #

  def fcs(*integers)
    integers.reduce(0) do |c,d|
      c^= d
    end
  end

  # ------------------------ HEX TO X ------------------------ #

  def hex_to_encoded(hex_value)
    hex_value.hex.chr(BINARY_ENCODING)
  end

  # @alias
  def h2d(hex_value)
    hex_to_decimal(hex_value)
  end

  def hex_to_decimal(hex_value)
    hex_value.hex
  end

  # @alias
  def h2b(hex, nibbles = false, prefix = false)
    hex_to_binary(hex, nibbles, prefix)
  end

  def hex_to_binary(hex, nibbles = false, prefix = false)
    hex = hex.to_s
    decimal_to_binary(hex.hex, nibbles, prefix)
  end

  # ------------------------ DECIMAL TO X ------------------------ #

  # @alias
  def d2h(decimal, prefix = false)
    decimal_to_hex(decimal, prefix = false)
  end

  def decimal_to_hex(decimal, prefix = false)
    raise EncodingError, 'nil byte...?' if decimal.nil?
    value = base16(decimal)

    if value.length == 1
      value = '0'.concat(value[0])
    elsif value.length == 2
      value = "#{value[0]}#{value[1]}"
    end

    value = prefix ? '0x'.concat(value) : value

    value
  end

  def decimal_to_binary(decimal, nibbles = false, prefix = false)
    to_binary(decimal, nibbles, prefix)
  end

  # ------------------------ BINARY TO X ------------------------ #

  # @alias
  def b2d(input_value)
    binary_to_decimal(input_value)
  end

  def binary_to_decimal(input_value)
    mask = "%#.d"
    str_buffer = Kernel.format(mask, input_value)
    return str_buffer
  end

  # ------------------------ ENC TO X ------------------------ #

  def encoded_to_decimal(value)
    value.bytes[0]
  end

  def encoded_to_hex(value)
    decimal = encoded_to_decimal(value)
    decimal_to_hex(decimal)
  end

  # @private

  def to_binary(input_value, nibbles = false, prefix = false)
    # prefix 0b
    mask = prefix ? "%#.8b" : "%.8b"
    str_buffer = Kernel.format(mask, input_value)
    # nibbles
    if nibbles && !prefix
      index = prefix ? 6 : 4
      str_buffer = str_buffer.insert(index, ' ')
    end
    return str_buffer
  end

  def base16(n, output = [])
    nibble = n.modulo(16)
    n -= nibble
    n = n.div(16)

    output.unshift(HEX[nibble])
    base16(n, output) if n > 0
    return *output
  end
end
