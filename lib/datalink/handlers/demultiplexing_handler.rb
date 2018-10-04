require 'singleton'

require 'application/message'
require 'maps/device_map'
require 'maps/command_map'
require 'maps/address_lookup_table'

require 'datalink/frame/indexed_arguments'

require 'command/parameter/indexed_bit_array'
require 'command/parameter/base_parameter'

require 'command/builder/base_command_builder'

class Packet
  attr_reader :from, :to, :data

  def initialize(from, to, data)
    @from = from
    @to = to
    @data = data
  end

  def inspect
    "<Packet Tx: #{from} Rx: #{to} Data: #{data}>"
  end

  def to_s
    "#{from.upcase}\t#{to.upcase}\t#{data}"
  end
end

class DemultiplexingHandler
  include Observable
  include Singleton
  include Event
  include Helpers

  PROC = 'DemultiplexingHandler'.freeze

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
      packet = strip_frame(properties[:frame])
      changed
      notify_observers(PACKET_RECEIVED, packet: packet)
    end
  end

  private

  def strip_frame(frame)
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
end
