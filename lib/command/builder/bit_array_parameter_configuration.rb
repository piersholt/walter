require 'command/builder/parameter_configuration'

class BitArrayParameterConfiguration < ParameterConfiguration
  PROC = 'BitArrayParamConf'.freeze

  attr_reader :parameters

  def initialize(parameter_name, parameter_hash)
    super(parameter_name, parameter_hash)
    parse_parameters(parameters_hash) if has_parameters?
  end

  def parse_parameters(mapped_parameters)
    LOGGER.debug(PROC) { "#parse_parameters(#{mapped_parameters})" }
    begin
      @parameters = {}
      mapped_parameters.each do |name, data|
        new_parameter = ParameterConfiguration.new(name, data)
        @parameters[name] = new_parameter
      end
    rescue StandardError => e
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  # def configure(object)
  #   super(object)
  # end

  def parameters_hash
    @parameter_hash[:parameters]
  end

  def has_parameters?
    parameters_hash.nil? ? false : true
  end

  def parameter_list
    @parameter_hash[:parameters].keys
  end

  def index
    @parameter_hash[:index]
  end

  def inspect
    "<#{PROC} @type=#{type} @parameter_list=#{parameter_list}>"
  end

  def to_s
    "<#{PROC} @type=#{type} @parameter_list=#{parameter_list}>"
  end

  def is_bit_array?
    true
  end

end
