require 'singleton'

require 'message'
require 'maps/device_map'
require 'maps/command_map'

require 'indexed_arguments'

class FrameHandler
  include Observable
  include Singleton
  include Event

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

    # FRAME = HEADER, PAYLOAD, FCS
    # MESSAGE = FROM, TO, COMMAND, ARGUMENTS

    from = frame.from
    from = from.to_d
    from = @device_map.find(from)

    to = frame.to
    to = to.to_d
    to = @device_map.find(to)

    arguments = frame.arguments

    command = frame.tail[1]
    command_id = command.to_d
    command = @command_map.klass(command_id, arguments)

    parameters = @command_map.parameters(command_id)
    unless parameters.nil?
      index = @command_map.index(command_id)
      indexed_args = IndexedArguments.new(arguments, index)

      LOGGER.debug("FrameHandler") { "Mapping command arguments." }
      indexed_args.parameters.each do |param|
        param_value = indexed_args.lookup(param)
        LOGGER.debug("FrameHandler") { "Parameter: #{param}= #{param_value}" }
        command.instance_variable_set(inst_var(param), param_value)
      end
    end

    m = Message.new(from, to, command, arguments)
    m.frame= frame
    m
  end
end
