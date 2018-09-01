# a byte collection
class ByteStream
  extend Forwardable

  FORWARD_MESSAGES = Array.instance_methods(false)
  FORWARD_MESSAGES.each do |fwrd_message|
    def_delegator :@bytes, fwrd_message
  end

  def initialize(bytes = [])
    @bytes = bytes
  end

  def to_s
    map(&:h).join(' ').to_s
  end

  def +(other)
    new_byte_strean = self.class.new
    result = @bytes[0..-1] + other[0..-1]
    new_byte_strean.wholesale(result)
    new_byte_strean
  end

  def wholesale(new_bytes)
    @bytes = new_bytes
  end

  # Testing if forwarded methods work internally... they do!
  def test
    @bytes = [1,2,3]
    self[0]
  end
end
