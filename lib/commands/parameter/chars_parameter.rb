require 'base_parameter'
require 'commands/chars'

class CharsParameter < BaseParameter
  PROC = 'CharsParameter'.freeze

  attr_reader :chars

  def initialize(configuration, char_array)
    super(configuration, char_array)
    format_char_array
  end

  def format_char_array
    LOGGER.warn(PROC) { "Cannot create @chars without value. Value = #{value}" } if value.nil?
    @chars = Commands::Chars.new(value, true)
  end

  # def to_s
  #   "A Thing: #{value} (Human Version)"
  # end

  def to_s
    "<#{PROC} @value=#{value}>"
  end

  def inspect
    "<#{PROC} @value=#{value}>"
  end


  # def append_chars(str_buffer)
  #   if !@chars.empty?
  #     str_buffer.concat("\t\"#{Chars.new(@chars, true)}\"")
  #   else
  #     str_buffer
  #   end
  # end

  def to_s
    "\"#{}\""
  end
end
