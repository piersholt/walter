class IndexedArguments < Bytes
  def initialize(bytes, index)
    super(bytes)
    @index = index

    # create_readers
  end

  def lookup(name)
    # binding.pry
    parameter_index = @index[name]
    d[parameter_index]
  end

  def parameters
    @index.keys
  end

  private

  # def create_readers
  #   attr_reader(*parameters)
  # end
end
