require 'singleton'

require 'application/message'
require 'maps/device_map'
require 'maps/command_map'

require 'datalink/frame/indexed_arguments'

require 'command/parameter/indexed_bit_array'
require 'command/parameter/base_parameter'

require 'command/builder/base_command_builder'

class DemultiplexingHandler
  include Observable
  include Singleton
  include Event
  include Helpers

  PROC = 'DemultiplexingHandler'.freeze

  def self.i
    instance
  end

  def initialize
    @device_map = DeviceMap.instance
    @command_map = CommandMap.instance
  end

  def inspect
    str_buffer = "<#{PROC}>"
  end

  def update(action, properties)
    case action
    when FRAME_RECEIVED
      message = process_frame(properties[:frame])
      changed
      notify_observers(MESSAGE_RECEIVED, message: message)
    end
  end

  private

  # ------------------------------ FRAME ------------------------------ #

  def process_frame(frame)
    LOGGER.debug(PROC) { "#{self.class}#process_frame(#{frame})" }
    LOGGER.debug(PROC) { frame.inspect }

    from      = frame.from
    to        = frame.to
    command   = frame.command
    arguments = frame.arguments

    from_id     = from.to_d
    to_id       = to.to_d
    command_id  = command.to_d

    from_object    = @device_map.find(from_id)
    to_object      = @device_map.find(to_id)

    command_config = @command_map.config(command_id, from_id)
    parameter_values_hash = parse_argumets(command_config, arguments)
    LOGGER.debug(PROC) { "Parameter Values: #{parameter_values_hash}" }
    command_object = build_command(command_config, parameter_values_hash)

    m = create_message(from_object, to_object, command_object, arguments, frame)

    m
  end

  def create_message(from, to, command_object, arguments, frame)
    LOGGER.debug(PROC) { "#create_message" }
    begin
      new_message = Message.new(from, to, command_object, arguments)
      new_message.frame= frame
      new_message
    rescue StandardError => e
      LOGGER.error(PROC) { 'Error while initializing message!' }
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
    end
  end

  # TODO: the builder will need to deal with this
  def parse_argumets(command_config, arguments)
    # LOGGER.info(PROC) { "#parse_argumets" }
    if command_config.has_parameters? && !command_config.is_base?
      # LOGGER.info(PROC) { "#{command_config.sn} has a klass and parameters. Will parse." }
       parse_indexed_arguments(command_config, arguments)
    else
      # LOGGER.info(PROC) { "#{command_config.sn} is getting plain old arguments." }
      arguments
    end
  end

  def parse_indexed_arguments(command_config, arguments)
    parameter_values_hash = {}
    begin
      argument_index = command_config.index
      LOGGER.debug(PROC) { "argument index: #{argument_index}" }
      indexed_arguments = IndexedArguments.new(arguments, argument_index)
      LOGGER.debug(PROC) { "indexed_arguments: #{indexed_arguments}" }

      indexed_arguments.parameters.each do |name|
        param_value = indexed_arguments.lookup(name)
        LOGGER.debug(PROC) { "indexed_arguments.lookup(#{name}) => #{param_value ? param_value : 'NULL'}" }
        parameter_values_hash[name] = param_value
      end

      parameter_values_hash
    rescue StandardError => e
      LOGGER.error(PROC ) {"#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  def build_command(command_config, parameter_values_hash)
    LOGGER.debug(PROC) { "#build_command" }
    begin
      command_builder = command_config.builder
      command_builder = command_builder.new(command_config)
      command_builder.add_parameters(parameter_values_hash)

      command_builder.result
    rescue StandardError => e
      LOGGER.error(PROC ) {"#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end
end
