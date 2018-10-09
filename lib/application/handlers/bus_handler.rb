class RoutingError < StandardError
  def message
    "A routing error has occured!"
  end
end

class BusHandler
  include Observable
  include Event
  include Helpers

  PROC = 'BusHandler'.freeze

  def initialize(options)
    @bus = options[:bus]
  end

  def update(action, properties)
    case action
    when PACKET_RECEIVED
      packet = properties[:packet]
      raise RoutingError, 'Packet is nil!' unless packet
      LOGGER.warn(PACKET_RECEIVED) { "#{packet}" }

      # publish_to_bus(packet)
    when PACKET_ROUTE
      packet = properties[:packet]
      raise RoutingError, 'Packet is nil!' unless packet
      publish_to_bus(packet)
    end
  end

  def register(recipient, observer)
    subscribers[recipient] << observer
  end

  def subscribers
    @subscribers ||= {}
  end

  def publish_to_bus(packet)
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
