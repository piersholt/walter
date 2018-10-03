require 'physical/bytes'

class TailValidationError < StandardError
end

class FrameTail < Bytes
  VALID_SIZE = (3..255)

  def initialize(bytes)
    validate_args(bytes)
    super(bytes)
  end

  def without_fcs
    self[0..-2]
  end

  # ************************************************************************* #
  #                                 BYTE MAP
  # ************************************************************************* #

  def to
    self[0]
  end

  def command
    self[1]
  end

  def payload
    Bytes.new(self[1..-2])
  end

  # a command may not have any arguments
  def arguments
    length > 3 ? self[2..-2] : []
  end

  def fcs
    self[-1]
  end

  def no_fcs
    self[0..-2]
  end

  # ************************************************************************* #
  #                             HEADER PROPERTIES
  # ************************************************************************* #

  def checksum
    fcs.d
  end

  private

  def validate_args(bytes)
    raise TailValidationError, 'invalid tail length'  unless VALID_SIZE.include?(bytes.length)
  end
end
