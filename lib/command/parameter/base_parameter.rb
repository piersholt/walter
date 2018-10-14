require 'helpers'

require 'command/parameter/delegated_command_parameter'

# this should have the map
# if you change the value, you shouldn't need to also set the display value etc
# it will need to be an instance variable
class BaseParameter
  # extend DelegatedCommandParameter

  include Helpers
  include DataTools

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

require 'command/parameter/base_parameter'
require 'command/parameter/bit_array_parameter'
require 'command/parameter/switched_parameter'
require 'command/parameter/mapped_parameter'
require 'command/parameter/chars_parameter'
