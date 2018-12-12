# require 'singleton'

require 'application/message'
require 'maps/device_map'
require 'maps/command_map'
require 'maps/address_lookup_table'

require 'datalink/frame/indexed_arguments'

require 'datalink/frame/frame_builder'

require 'command/parameter/indexed_bit_array'
require 'command/parameter/base_parameter'

require 'command/builder/base_command_builder'

require 'datalink/packet'

class FrameHandler < BaseHandler
  # include Singleton

  PROC = 'FrameHandler'.freeze

  include Event

  attr_reader :queue

  # def self.i
  #   instance
  # end

  def initialize(frame_output_buffer, address_lookup_table = AddressLookupTable.instance)
    @frame_output_buffer = frame_output_buffer
    @address_lookup_table = address_lookup_table
  end

  def queue_frame(frame)
    @frame_output_buffer << frame
  end

  def inspect
    str_buffer = "<#{PROC}>"
  end

  def update(action, properties)
    # case action
    # when FRAME_RECEIVED
    #   frame = fetch(properties, :frame)
    #   packet = demultiplex(frame)
      # queue_packet(packet)

      # changed
      # notify_observers(PACKET_RECEIVED, packet: packet)
    # when MESSAGE_SENT
    #   message = fetch(properties, :message)
    #   frame = multiplex(message)
    #   queue_frame(frame)
    # end
    false
  end

  private

  # def demultiplex(frame)
  #   from      = frame.from
  #   from_id   = from.to_i
  #   from_device = @address_lookup_table.find(from_id)
  #   LogActually.datalink.debug(PROC) { "from_device: #{from_device}" }
  #
  #   to        = frame.to
  #   to_id     = to.to_i
  #   to_device   = @address_lookup_table.find(to_id)
  #   LogActually.datalink.debug(PROC) { "to_device: #{to_device}" }
  #
  #   payload   = frame.payload
  #   LogActually.datalink.debug(PROC) { "payload: #{payload}" }
  #
  #   packet = Packet.new(from_device, to_device, payload)
  #   LogActually.datalink.debug('MultiplexingHandler') { "Packet build: #{packet}" }
  #   packet
  # end
  #
  # # @return Frame
  # def multiplex(message)
  #   frame_builder = FrameBuilder.new
  #
  #   frame_builder.from = message.from.d
  #   frame_builder.to = message.to.d
  #   frame_builder.command = message.command
  #
  #   frame = frame_builder.result
  #   LogActually.datalink.debug('MultiplexingHandler') { "Frame build: #{frame}" }
  #   frame
  # end
end
