require 'singleton'

require 'message'
require 'maps/device_map'
require 'maps/command_map'

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
    when FRAME_VALIDATED
      message = process_frame(properties[:frame])
      changed
      notify_observers(MESSAGE_RECEIVED, message: message)
    end
  end

  private

  # ------------------------------ FRAME ------------------------------ #

  def process_frame(frame)
    LOGGER.debug("FrameHandler") { "#{self.class}#process_frame(#{frame})" }
    LOGGER.debug("FrameHandler") { frame.inspect }

    # FRAME = HEADER, PAYLOAD, FCS
    # MESSAGE = FROM, TO, COMMAND, ARGUMENTS

    from = frame.header[0]
    from = from.to_d
    from = @device_map.find(from)

    to = frame.tail[0]
    to = to.to_d
    to = @device_map.find(to)

    arguments = frame.tail[2..-2]

    command = frame.tail[1]
    command_id = command.to_d
    command = @command_map.find(command_id, arguments)

    m = Message.new(from, to, command, arguments)
    m.frame= frame
    m
  end
end
