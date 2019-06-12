# frozen_string_literal: false

# Comment
class IndexedArguments < Bytes
  def initialize(bytes, index)
    super(bytes)
    @index = index
  end

  def lookup(name)
    parameter_index = @index[name]
    d[parameter_index]
  end

  def parameters
    @index.keys
  end

  def to_s
    "Index: #{@index}\tBytes:".concat(super)
  end

  def inspect
    to_s
  end
end
