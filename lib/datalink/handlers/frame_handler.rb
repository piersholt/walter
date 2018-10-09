require 'singleton'

require 'application/message'
require 'maps/device_map'
require 'maps/command_map'
require 'maps/address_lookup_table'

require 'datalink/frame/indexed_arguments'

require 'command/parameter/indexed_bit_array'
require 'command/parameter/base_parameter'

require 'command/builder/base_command_builder'

require 'application/packet'

class FrameHandler
  include Observable
  include Singleton
  include Event
  include Helpers

  PROC = 'FrameHandler'.freeze

  def self.i
    instance
  end

  def initialize(address_lookup_table = AddressLookupTable.instance)
    @address_lookup_table = address_lookup_table
  end

  def inspect
    str_buffer = "<#{PROC}>"
  end

  def update(action, properties)
    case action
    when FRAME_RECEIVED
      frame = properties[:frame]
      packet = demultiplex(frame)

      changed
      notify_observers(PACKET_RECEIVED, packet: packet)
    when MESSAGE_SENT
      message = properties[:message]
      frame = multiplex(message)

      changed
      notify_observers(FRAME_SENT, frame: frame)
    end
  end

  private

  def demultiplex(frame)
    from      = frame.from
    from_id   = from.to_i
    from_device = @address_lookup_table.find(from_id)
    LOGGER.debug(PROC) { "from_device: #{from_device}" }

    to        = frame.to
    to_id     = to.to_i
    to_device   = @address_lookup_table.find(to_id)
    LOGGER.debug(PROC) { "to_device: #{to_device}" }

    payload   = frame.payload
    LOGGER.debug(PROC) { "payload: #{payload}" }

    Packet.new(from_device, to_device, payload)
  end

  # @return Frame
  def multiplex(message)
    frame_builder = FrameBuilder.new

    frame_builder.from = message.from.d
    frame_builder.to = message.to.d
    frame_builder.command = message.command

    frame = frame_builder.result
    LOGGER.warn('MultiplexingHandler') { "Frame build: #{frame}" }
    frame
  end
end
