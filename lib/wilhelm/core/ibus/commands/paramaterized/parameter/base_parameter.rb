

# require 'application/commands/parameter/delegated_command_parameter'

# this should have the map
# if you change the value, you shouldn't need to also set the display value etc
# it will need to be an instance variable
class Wilhelm::Core::BaseParameter
  # extend DelegatedCommandParameter

  include Wilhelm::Core::Helpers
  include Wilhelm::Helpers::DataTools

  DEFAULT_LABEL_WIDTH = 0
  LABEL_DELIMITER = ' '
  PROC = 'CommandParam'

  attr_reader :value, :name

  def initialize(configuration, value)
    configuration.configure(self)
    @value = value
  end

  def inspect
    str_buffer = "<#{PROC} @value=#{value}>"
  end

  def to_s
    "#{name}: \"#{value}\""
  end
end

# # require 'application/commands/parameter/base_parameter'
# require 'application/commands/parameter/bit_array_parameter'
# require 'application/commands/parameter/switched_parameter'
# require 'application/commands/parameter/mapped_parameter'
# require 'application/commands/parameter/chars_parameter'