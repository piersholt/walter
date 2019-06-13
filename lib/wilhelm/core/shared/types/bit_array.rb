class Wilhelm::Core::BitArray
  class DataError < StandardError
    def message
      "Binary data failure"
    end
  end
  extend Forwardable
  include Wilhelm::Helpers::DataTools

  FORWARD_MESSAGES = Array.instance_methods(false)
  FORWARD_MESSAGES << :reduce
  FORWARD_MESSAGES.each do |fwrd_message|
    def_delegator :@bits, fwrd_message
  end

  def initialize(bit_array = Array.new(8, 0))
    @bits = bit_array
  end

  # @param value : Integer
  def parse_integer(integer)
    binary_string = d2b(integer)
    parse_string(binary_string)
  end

  def self.from_i(int)
    bit_array = Wilhelm::Core::BitArray.new
    bit_array.parse_integer(int)
    bit_array
  end

  # @param binary_string Binary bit in String format i.e. "01100010"
  def parse_string(binary_string)
    raise DataError if binary_string.length > 8
    bit_chars = binary_string.chars
    bit_integers = bit_chars.map(&:to_i)
    @bits = bit_integers
  end

  def to_s
    mapped_bits = @bits.map do |bit|
      if bit == 0
        as_false(bit)
      elsif bit == 1
        as_true(bit)
      end
    end

    nibble_1 = mapped_bits.slice(0..3)
    nibble_2 = mapped_bits.slice(4..7)

    nibble_1_string = nibble_1.join
    nibble_2_string = nibble_2.join

    "#{nibble_1_string} #{nibble_2_string}"

  end

  def as_false(bit)
    as_colour(bit, 2)
  end

  def as_true(bit)
    as_colour(bit, 92)
  end

  def as_colour(string, colour_id)
    str_buffer = "\33[#{colour_id}m"
    str_buffer = str_buffer.concat("#{string}")
    str_buffer = str_buffer.concat("\33[0m")
    str_buffer
  end
end
