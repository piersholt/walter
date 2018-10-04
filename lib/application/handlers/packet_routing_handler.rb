class RoutingError < StandardError
  def message
    "A routing error has occured!"
  end
end

class PacketRoutingHandler
  include Observable
  include Singleton
  include Event
  include Helpers

  def self.i
    instance
  end

  def update(action, properties)
    case action
    when PACKET_RECEIVED
      packet = properties[:packet]
      raise RoutingError, 'Packet is nil!' unless packet
      route_packet(packet)
    end
  end

  def register(recipient, observer)
    subscribers[recipient] << observer
  end

  def subscribers
    @subscribers ||= {}
  end

  def route_packet(packet)
    recipient = packet.to
    raise RoutingError, 'Recipient is nil!' unless recipient
    observers = subscribers[recipient]
    raise RoutingError, "No observers of #{recipient}" if observers.nil? || observers.empty?
    observers.each do |subscriber|
      send_packet(subscriber, packet)
    end
  end

  def send_packet(subscriber, packet)
    subscriber.send_packet(packet)
  end
end
