class ArgumentsBuilder
  def initialize(command, index)
    @command = command
    @index = index

    map_arguments
  end

  def result
    map_arguments
  end

  def map_arguments
    values_with_index = @index.map do |param, index|
      param_value = @command.public_send(param)
      [param_value, index]
    end

    values_with_index.sort_by! do |object|
      index = object[1]
      index.instance_of?(Range) ? index.first : index
    end

    values_with_index.map do |object|
      object[0]
    end
  end
end
