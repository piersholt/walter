require 'application/commands/parameter/base_parameter'

class MappedParameter < BaseParameter
  PROC = 'MappedParameter'.freeze

  attr_accessor :map, :dictionary, :label
  def initialize(configuration, integer)
    super(configuration, integer)
  end

  def inspect
    "<#{PROC} @value=#{value}>"
  end

  def to_s(width = DEFAULT_LABEL_WIDTH)
    str_buffer = ""
    str_buffer = str_buffer.concat("#{pretty}")
    str_buffer
  end

  def pretty
    if value.nil?
      return '--'
    elsif @dictionary.nil?
      LOGGER.warn(PROC) { "Map @dictionary is nil!" }
      return "\"value\""
    elsif !@dictionary.key?(value)
      return "#{d2h(value, true)} not found!"
    else
      @dictionary[value]
    end
  end
end
