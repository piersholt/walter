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

  # ************************************************************************* #
  #                               FORMATTING
  # ************************************************************************* #

  def as_string
   self.map(&:to_e).join
  end

  def d
    self.map(&:to_d)
  end

  def h
    self.map(&:to_h)
  end
end
