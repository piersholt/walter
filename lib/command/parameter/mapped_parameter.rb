require 'command/parameter/base_parameter'

class MappedParameter < BaseParameter
  PROC = 'MappedParameter'.freeze

  attr_accessor :map, :dictionary, :label
  def initialize(configuration, integer)
    super(configuration, integer)
  end

  def inspect
    "<#{PROC} @value=#{value}>"
  end

  # @overide
  def to_s(width = DEFAULT_LABEL_WIDTH)
    # LOGGER.info(PROC) { "#to_s(width = #{width})" }
    # str_buffer = format("%-#{width}s", "#{label}#{LABEL_DELIMITER}")
    str_buffer = ""
    # str_buffer = str_buffer.concat(LABEL_DELIMITER)
    str_buffer = str_buffer.concat("#{pretty}")
    str_buffer
  end

  # def human_value
  #   @human_value ||= @dictionary[value]
  # end

  def pretty
    if @dictionary.nil?
      LOGGER.warn(PROC) { "Map @dictionary is nil!" }
      return "\"value\""
    elsif !@dictionary.key?(value)
      LOGGER.warn(PROC) { "#{name}: #{d2h(value, true)} not found in @dictionary!" }
      LOGGER.warn(PROC) { "#{name}: Dictionary: #{dictionary}" }
      return "No states value!"
    else
      @dictionary[value]
    end
  end

  # def try_dictionary(value)
  #   return "NO DICTIONARY" if @dictionary.nil?
  #   return "No dictionary value!" unless @dictionary.key?(value)
  #   @dictionary[value]
  # end
end
