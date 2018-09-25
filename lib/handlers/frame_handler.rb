require 'singleton'

require 'message'
require 'maps/device_map'
require 'maps/command_map'

require 'indexed_arguments'
require 'indexed_bit_array'

require 'base_parameter'

require 'command_builder'

class FrameHandler
  include Observable
  include Singleton
  include Event

  PROC = 'FrameHandler'

  MESSAGE_COMPONENTS = [:from, :to, :command, :arguments].freeze
  FRAME_TO_MESSAGE_MAP = {
    from: { frame_component: :header,
            component_index: 0 },
    to: { frame_component: :tail,
          component_index: 0 },
    command: {  frame_component: :tail,
                component_index: 1 },
    arguments: { frame_component: :tail,
                 component_index: 2..-2 } }.freeze

  def self.i
    instance
  end

  def initialize
    @device_map = DeviceMap.instance
    @command_map = CommandMap.instance
  end

  def inspect
    str_buffer = "<FrameHandler>"
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

  def inst_var(name)
    name_string = name.id2name
    '@'.concat(name_string).to_sym
  end


  # ------------------------------ FRAME ------------------------------ #

  def process_frame(frame)
    LOGGER.debug("FrameHandler") { "#{self.class}#process_frame(#{frame})" }
    LOGGER.debug("FrameHandler") { frame.inspect }

    from      = frame.from
    to        = frame.to
    command   = frame.command
    arguments = frame.arguments


    from_id     = from.to_d
    to_id       = to.to_d
    command_id  = command.to_d

    from    = @device_map.find(from_id)
    to      = @device_map.find(to_id)


    command_config = @command_map.config(command_id)
    # LOGGER.info("FrameHandler") { "Arguments: #{arguments}" }
    parameter_values_hash = parse_argumets(command_config, arguments)
    # LOGGER.info("FrameHandler") { "Parameter Values: #{parameter_values_hash}" }
    command_object = build_command(command_config, parameter_values_hash)

    m = Message.new(from, to, command_object, arguments)
    m.frame= frame
    m
  end

  def parse_argumets(command_config, arguments)
    # LOGGER.info("FrameHandler") { "#parse_argumets" }
    if command_config.has_parameters? && !command_config.is_base?
      # LOGGER.info("FrameHandler") { "#{command_config.sn} has a klass and parameters. Will parse." }
       parse_indexed_arguments(command_config, arguments)
    else
      # LOGGER.info("FrameHandler") { "#{command_config.sn} is getting plain old arguments." }
      arguments
    end
  end

  def parse_indexed_arguments(command_config, arguments)
    parameter_values_hash = {}
    begin
      argument_index = command_config.index
      indexed_arguments = IndexedArguments.new(arguments, argument_index)

      indexed_arguments.parameters.each do |name|
        param_value = indexed_arguments.lookup(name)
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
    LOGGER.debug("FrameHandler") { "#build_command" }
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

  # def map_arguments_to_parameters(command, arguments)
  #   command_config = @command_map.config(command_id)
  #   return false unless command_config.has_parameters?
  #
  #   begin
  #     LOGGER.debug("FrameHandler") { "Mapping command arguments to parameters." }
  #
  #     index = command_config.index
  #     indexed_args = IndexedArguments.new(arguments, index)
  #
  #     indexed_args.parameters.each do |param|
  #       param_value = indexed_args.lookup(param)
  #
  #       param_config = command_config.parameters[param]
  #       param_type = param_config.type
  #
  #       command_param = BaseParameter.create(param_config, param_type, param_value)
  #       param_config.configure(command_param)
  #       command.instance_variable_set(inst_var(param), command_param)
  #     end
  #   rescue StandardError => e
  #     LOGGER.error("#{self.class} StandardError: #{e}")
  #     e.backtrace.each { |l| LOGGER.error(l) }
  #     binding.pry
  #   end
  #   true
  # end

  # def process_nested_parameters(command, data, index)
  #   LOGGER.debug("FrameHandler") { "Mapping command nested arguments." }
  #   bit_array = BitArray.from_i(data)
  #   indexed_bit_array = IndexedBitArray.new(bit_array, index)
  #   indexed_bit_array.parameters.each do |param|
  #     param_value = indexed_bit_array.lookup(param)
  #     LOGGER.debug("FrameHandler") { "Parameter: #{param}= #{param_value}" }
  #     command.instance_variable_set(inst_var(param), param_value)
  #   end
  # end
end
