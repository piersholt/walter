# A collection class for Byte
class Bytes
  extend Forwardable

  FORWARD_MESSAGES = Array.instance_methods(false)
  FORWARD_MESSAGES.each do |fwrd_message|
    def_delegator :@bytes, fwrd_message
  end

  # ************************************************************************* #
  #                                  OBJECT
  # ************************************************************************* #

  def initialize(bytes = [])
    @bytes = bytes
  end

  def to_s
    map(&:h).join(' ').to_s
  end

  def inspect
    "<Bytes> ".concat(map(&:h).join(' '))
  end

  def to_s
    string_buffer = map(&:h).join(' ').to_s
    string_buffer.prepend("<Bytes> ")
  end

  # ************************************************************************* #
  #                               COLLECTION
  # ************************************************************************* #

  def wholesale(new_bytes)
    @bytes = new_bytes
  end

  # Testing if forwarded methods work internally... they do!
  def test
    @bytes = [1,2,3]
    self[0]
  end

  def as_d
    @bytes.map(&:h)
  end
end
