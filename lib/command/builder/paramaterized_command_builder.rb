require 'base_command_builder'

# For command classes that have parameters
class ParameterizedCommandBuilder < BaseCommandBuilder
  def add_parameters(parameter_value_hash)
    LOGGER.debug('ParameterizedCommandBuilder') { "#add_parameters(#{parameter_value_hash})" }
    @command_config.parameters.each do |param_name, param_config|
      param_value = parameter_value_hash[param_name]
      param_object = parse_parameter(param_name, param_config, param_value)
      add_parameter(param_name, param_object)
    end
  end

  def parse_parameter(param_name, param_config, param_value)
    LOGGER.debug('ParameterizedCommandBuilder') { "#parse_parameter(#{param_name}, #{param_config}, #{param_value})" }
    param_type  = param_config.type

    param_object = DelegatedCommandParameter.create(param_config, param_type, param_value)
    param_config.configure(param_object)

    param_object
  end

  def add_parameter(param_name, param_object)
    LOGGER.debug('ParameterizedCommandBuilder') { "#add_parameter(#{param_name}, #{param_object})" }
    @parameter_objects[param_name] = param_object
  end

  def result
    LOGGER.debug('ParameterizedCommandBuilder') { "#result()" }
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
