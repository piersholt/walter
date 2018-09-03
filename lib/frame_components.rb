require 'bytes'

class HeaderError  < StandardError
end

class TailError < StandardError
end

class FrameHeader < Bytes
  VALID_SIZE = (2..2)

  MIN_LENGTH_VALUE = (3..255)
  LENGTH_INDEX = 1

  def initialize(bytes)
    validate_args(bytes)
    super(bytes)
  end

  def tail_length
    @bytes[1].d
  end

  private

  def validate_args(bytes)
    raise ArgumentError, 'invalid header length'  unless VALID_SIZE.include?(bytes.length)
    tail_length_value = bytes[LENGTH_INDEX].d
    raise HeaderError, 'invalid frame length' unless MIN_LENGTH_VALUE.include?(tail_length_value)
  end
end

class FrameTail < Bytes
  VALID_SIZE = (3..255)

  def initialize(bytes)
    validate_args(bytes)
    super(bytes)
  end

  def without_fcs
    @bytes[0..-2]
  end

  def fcs
    @bytes[-1].d
  end

  private

  def validate_args(bytes)
    raise ArgumentError, 'invalid tail length'  unless VALID_SIZE.include?(bytes.length)
  end
end
