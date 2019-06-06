class IndexedBitArray < BitArray
  BASE_2 = 2

  def initialize(bit_array = nil, index = nil)
    super(bit_array)
    @index = index
  end

  def add_index(index)
    @index = index
  end

  def lookup(name)
    parameter_index = index_as_range(name)
    bits = slice(parameter_index)
    str_buffer = bits.join
    str_buffer = str_buffer.prepend('0b')
    integer = str_buffer.to_i(BASE_2)
  # it was fog_front!
  rescue TypeError => e
    LOGGER.unknown(name) { e }
    LOGGER.unknown(name) { e.cause }
    e.backtrace.each { |l| LOGGER.unknown(l) }
    binding.pry
  end

  def parameters
    @index.keys
  end

  private

  def index_as_range(name)
    parameter_index = @index[name]
    return parameter_index if parameter_index.instance_of?(Range)
    Range.new(parameter_index, parameter_index)
  end
end
