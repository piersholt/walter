# frozen_string_literal: true

require 'data_link/frame/frame'
require 'data_link/frame/arguments_builder'

# Class documentation
class FrameBuilder
  REQUIRED_FIELDS = %i[from to command arguments].freeze
  CALCULATED_FIELDS = %i[length fcs].freeze
  ALL_FIELDS = REQUIRED_FIELDS + CALCULATED_FIELDS

  DEFAULT_VALUE = nil
  INST_VAR_PREFIX = '@'

  DEFAULT_LENGTH = 1
  ARGS_INDEX = 2
  ARGS_TAIL_INDEX = ARGS_INDEX
  ARGS_FRAME_INDEX = -1

  attr_accessor :arguments
  attr_reader :from, :to, :command
  attr_reader :length, :fcs

  def initialze
    ALL_FIELDS.each do |field|
      instance_variable_set(inst_var(field), DEFAULT_VALUE)
    end
  end

  def clone(frame)
    @from = frame.from
    LogActually.datalink.warn('FrameBuilder') { "from: #{from}" }
    @to = frame.to
    LogActually.datalink.warn('FrameBuilder') { "to: #{to}" }
    @command = frame.command
    LogActually.datalink.warn('FrameBuilder') { "command: #{command}" }
    @arguments = frame.arguments
    LogActually.datalink.warn('FrameBuilder') { "arguments: #{arguments}" }
    true
  end

  def from=(device_id)
    @from = Byte.new(:decimal, device_id)
  end

  def to=(device_id)
    @to = Byte.new(:decimal, device_id)
  end

  def command=(command)
    begin
      command_id = command.d
      @command = Byte.new(:decimal, command_id)

      command_config = CommandMap.instance.config(command_id)
      index = command_config.index
      builder = ArgumentsBuilder.new(command, index)
      args = builder.result
      nested_arguments = args.map do |d|
        if d.instance_of?(Array)
          array_of_bytes = d.map { |i| Byte.new(:decimal, i) }
          Bytes.new(array_of_bytes)
        else
          Byte.new(:decimal, d)
        end
      end
      flattened_arguments = nested_arguments.flatten

      self.arguments= flattened_arguments
    rescue StandardError => e
      LogActually.datalink.error("#{self.class} Exception: #{e}")
      e.backtrace.each { |l| LogActually.datalink.error(l) }
      puts "breakpoint"
      puts "breakpoint!"
    end
  end

  def result
    raise ArgumentError, 'req fields not set!' unless all_required_fields_set?

    generate_calculated_fields
    new_frame = generate_new_frame
    new_frame.valid?
    new_frame
  end

  def generate_calculated_fields
    generate_length
    generate_fcs
  end

  def generate_new_frame
    new_frame = Frame.new
    new_frame.set_header(generate_header)
    new_frame.set_tail(generate_tail)
    new_frame
  end

  def generate_header
    Bytes.new([from, length])
  end

  def generate_tail
    bytes = Bytes.new([to, command, fcs])
    bytes.insert(ARGS_INDEX, *arguments) unless no_arguments?
    bytes
  end

  def no_arguments?
    raise ArgumentError, 'command args hasn\'t been set yet!' if arguments.nil?
    arguments.empty?
  end

  def all_required_fields_set?
    result = REQUIRED_FIELDS.none?(&:nil?)
    return true if result
    fields_not_set = REQUIRED_FIELDS.find_all(&:nil?)
    LogActually.datalink.warn('FrameBuilder') { "Required fields: #{fields_not_set}" }
    false
  end

  def calculate_length
    to_len =       DEFAULT_LENGTH
    command_len =  DEFAULT_LENGTH
    args_len =     @arguments.length
    fcs_len =      DEFAULT_LENGTH

    buffer = to_len + command_len + args_len + fcs_len
    LogActually.datalink.debug('FrameBuilder') { "length / Calculated = #{buffer}" }
    buffer
  end

  def calculate_fcs
    checksum = all_fields.reduce(0) { |c, d| c ^= d.to_d }
    LogActually.datalink.debug('FrameBuilder') { "Checksum / Calculated = #{checksum}" }
    checksum
  end

  def generate_fcs
    @fcs = Byte.new(:decimal, calculate_fcs)
  end

  def generate_length
    @length = Byte.new(:decimal, calculate_length)
  end

  def all_fields
    bytes = Bytes.new([from, length, to, command])
    bytes.insert(ARGS_TAIL_INDEX, *arguments) unless no_arguments?
    LogActually.datalink.debug("FrameBuilder") { "#{bytes}" }
    bytes
  end

  def inst_var(name)
    name_string = name.id2name
    INST_VAR_PREFIX.concat(name_string).to_sym
  end
end
