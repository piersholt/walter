require 'helpers'

class Byte
  include DataTools

  def initialize(format, value)
    fail ArgumentError, 'One valid data type required' unless FORMATS.include?(format)

    validate(format, value)
    parse(format, value)
  end

  def eql?(other_byte)
    self.d == other_byte.d
  end

  def ==(object)
    self.d == object
  end

  def <=>(other_byte)
    self.d <=> other_byte.d
  end

  def to_h(prefix = false)
    decimal_to_hex(@decimal, prefix)
  end

  def to_s(prefix = false)
    to_h(prefix)
  end

  def to_e
    hex_to_encoded(@hex)
  end

  def d
    @decimal
  end

  def h(prefix = false)
    to_h(prefix)
  end

  def b(nibbles = false)
    str_buffer = Kernel.format("%.8b", h(true))
    str_buffer = str_buffer.insert(4, ' ') if nibbles
    return str_buffer
  end

  def to_d
    @decimal
  end

  private

  def validate(format, value)
    case format
    when :encoded
      fail ArgumentError, 'Incorrect Encoding' unless value.encoding == Encoding::ASCII_8BIT
      fail ArgumentError, 'Length greater than 1' if value.length > 1
    when :hex
      @decimal = hex_to_decimal(value)
    when :decimal
      @decimal = value
    end
  end

  def parse(format, value)
    # begin
      case format
      when :encoded
        @decimal = encoded_to_decimal(value)
        # @hex = encoded_to_hex(value)
        @hex = decimal_to_hex(@decimal)
      when :hex
        @decimal = hex_to_decimal(value)
        @hex = value
      when :decimal
        @decimal = value
        @hex = decimal_to_hex(value)
      end
    # rescue EncodingError => e
    #   CheapLogger.interface.error('A read byte was nil!')
    #   e.backtrace.each { |l| CheapLogger.interface.error l }
    #   binding.pry
    #   # CheapLogger.interface.error("POS: #{@stream}")
    # end
  end
end
