require 'helpers'

require 'delegated_command_parameter'

# this should have the map
# if you change the value, you shouldn't need to also set the display value etc
# it will need to be an instance variable
class CommandParameter
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
    str_buffer = "<#{PROC} @value = {value}"
    # str_buffer = str_buffer.concat(" @indexed_bit_array=#{indexed_bit_array}")
    # str_buffer = str_buffer.concat("[#{aligned_parameters}]")
    str_buffer.concat(">")
  end

  def to_s
    value
  end
end

require 'command_parameter'
require 'bit_array_parameter'
require 'switched_parameter'
require 'mapped_parameter'
require 'chars_parameter'
