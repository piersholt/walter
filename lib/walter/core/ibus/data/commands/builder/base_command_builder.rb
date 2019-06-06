

class BaseCommandBuilder
  include Helpers

  def initialize(command_config)
    @command_config = command_config
    @parameter_objects = {}
  end

  def add_parameters(byte_stream)
    @arguments = byte_stream
  end

  def result
    LOGGER.debug('BaseCommandBuilder') { "#result()" }
    command_klass = @command_config.klass_constant

    command_id  = @command_config.id
    properties  = @command_config.properties_hash
    properties[:arguments] = @arguments

    command_object = command_klass.new(command_id, properties)
    # command_object.set_parameters(@parameter_objects)

    command_object
  end

end
