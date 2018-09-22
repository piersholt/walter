require 'helpers'

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
    command_klass = @command_config.klass_constant

    command_id  = @command_config.id
    properties  = @command_config.properties_hash
    properties[:arguments] = @arguments

    command_object = command_klass.new(command_id, properties)
    # command_object.set_parameters(@parameter_objects)

    command_object
  end

end

class CommandBuilder < BaseCommandBuilder
  def add_parameters(parameter_value_hash)
    LOGGER.debug('CommandBuilder') { "#add_parameters(#{parameter_value_hash})" }
    @command_config.parameters.each do |param_name, param_config|
      param_value = parameter_value_hash[param_name]
      add_parameter(param_name, param_config, param_value)
    end
  end

  def add_parameter(param_name, param_config, param_value)
    LOGGER.debug('CommandBuilder') { "#add_parameter(#{param_name}, #{param_config}, #{param_value})" }
    param_type  = param_config.type

    param_object = DelegatedCommandParameter.create(param_config, param_type, param_value)
    param_config.configure(param_object)

    @parameter_objects[param_name] = param_object
  end

  def result
    LOGGER.debug('CommandBuilder') { "#result()" }
    command_klass = @command_config.klass_constant

    command_id  = @command_config.id
    properties  = @command_config.properties_hash

    command_object = command_klass.new(command_id, properties)
    # command_object.set_parameters(@parameter_objects)
    @parameter_objects.each do |k, v|
      command_object.instance_variable_set(inst_var(k), v)
    end

    command_object
  end

end
