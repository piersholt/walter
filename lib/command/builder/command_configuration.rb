require 'helpers'
require 'command/builder/parameter_configuration'
require 'command/builder/bit_array_parameter_configuration'
require 'command/builder/base_command_builder'
require 'command/builder/paramaterized_command_builder'

class CommandConfiguration
  include Helpers
  PROC = 'CommandConfig'.freeze

  MAP = :map
  SWITCH = :switch
  BIT_ARRAY = :bit_array
  TYPES = [MAP, BIT_ARRAY, SWITCH].freeze

  DEFAULT_COMMAND_NAMESPACE = 'Command'.freeze
  BASE_COMMAND_STRING = 'BaseCommand'.freeze

  WRAPPER = ParameterConfiguration

  attr_reader :id, :parameters, :normal_fucking_decimal

  def initialize(mapped_command)
    @command_hash = mapped_command.dup
    parse_command(@command_hash)
    parse_parameters(parameters_hash) if has_parameters?
    configure_class unless configured?
  end

  def inspect
    "<#{PROC}> @id=#{id} @klass=#{klass} @has_parameters=#{has_parameters?} @parameter_list=#{parameter_list}"
  end

  def builder
    case
    when has_parameters? && is_base?
      get_class('BaseCommandBuilder')
    when has_parameters?
      get_class('ParameterizedCommandBuilder')
    else
      get_class('BaseCommandBuilder')
    end
  end

  def has_builder?
    @command_hash[:builder] ? true : false
  end

  def klass
    @klass ||= @command_hash[:klass]
  end

  def klass_constant
    full_klass_name = prepend_namespace(DEFAULT_COMMAND_NAMESPACE, klass)
    get_class(full_klass_name)
  end

  def parameter_list
    parameters_hash.keys
  end

  def index
    @command_hash[:index]
  end

  # Parameter Types

  def has_bit_arrays?
    return false unless has_parameters?
    parameters.any? { |name, data| data.type == BIT_ARRAY }
  end

  def properties_hash
    @command_hash[:properties]
  end

  def parameters_hash
    @command_hash[:parameters]
  end

  # Initialization -------------------------------------------------------

  def parse_command(mapped_command)
    command_id = @command_hash[:default_id]
    id_byte = Byte.new(:decimal, command_id)
    @command_hash[:id] = id_byte
    @id = id_byte
    @normal_fucking_decimal = command_id
  end

  def each_parameter
    parameters.each
  end

  def parse_parameters(mapped_parameters)
    @parameters = {}
    mapped_parameters.each do |name, data|
      new_parameter =
        case
        when data[:type] == BIT_ARRAY
          BitArrayParameterConfiguration.new(name, data)
        else
          ParameterConfiguration.new(name, data)
        end
      @parameters[name] = new_parameter
    end
  end

  # Class Properties -------------------------------------------------------

  def has_parameters?
    parameters_hash.nil? ? false : true
  end

  def is_base?
    klass == BASE_COMMAND_STRING
  end

  def prepend_namespace(command_namespace, klass)
    "#{command_namespace}::#{klass}"
  end

  # Class Configuration -------------------------------------------------------

  def configure_class
    LOGGER.debug(PROC) { "#{sn}: Class Configuration beginning." }
    setup_class_variable
    setup_klass_parameters
    LOGGER.debug(PROC) { "#{sn}: Class Configuration completed." }
    true
  end

  def sn
    properties_hash[:short_name]
  end

  def configured?
    if !has_parameters?
      LOGGER.debug(PROC) { "#{sn} has no parameters! Configuration not required." }
      true
    elsif is_base?
      LOGGER.debug(PROC) { "Configuration not required for BaseCommand" }
      true
    elsif klass_constant.class_variable_defined?(:@@configured)
      LOGGER.debug(PROC) { "#{sn} configuration already completed." }
      true
    else
      LOGGER.debug(PROC) { "Thy #{sn} configuration be done!" }
      false
    end
  end

  def setup_class_variable
    klass_constant.class_variable_set(:@@configured, true)
    # klass_constant.class_variable_set(:@@parameters, parameters_hash)
    # klass_constant.const_set(:DICTIONARY, {})
  end

  def setup_klass_parameters
    parameters.each do |name, param_config|
      setup_parameter_accessor(name)
    end
  end

  def setup_parameter_accessor(parameter)
    LOGGER.debug(PROC) { "Adding #{parameter} accessor" }
    klass_constant.class_eval do
      attr_accessor parameter
    end
  end
end
