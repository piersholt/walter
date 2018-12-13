require 'application/commands/parameter/base_parameter'
require 'application/commands/chars'

class CharsParameter < BaseParameter
  PROC = 'CharsParameter'.freeze

  attr_reader :chars

  def initialize(configuration, char_array)
    super(configuration, char_array)
    format_char_array
  end

  def format_char_array
    LOGGER.warn(PROC) { "Cannot create @chars without value. Value = #{value}" } if value.nil?
    @chars = Command::Chars.new(value, true)
  end

  def to_s
    "#{value} (#{@chars})"
  end

  def inspect
    "<#{PROC} @value=#{value} @chars=#{chars}>"
  end

  def empty?
    chars.char.nil?
  end

  def length
    chars.char.length
  end


  # def append_chars(str_buffer)
  #   if !@chars.empty?
  #     str_buffer.concat("\t\"#{Chars.new(@chars, true)}\"")
  #   else
  #     str_buffer
  #   end
  # end

  def to_s
    "\"#{chars}\""
  end
end
