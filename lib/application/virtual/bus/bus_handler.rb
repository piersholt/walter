class RoutingError < StandardError
  def message
    "A routing error has occured!"
  end
end

class BusHandler < BaseHandler
  PROC = 'BusHandler'.freeze

  def initialize(options)
    @bus = options[:bus]
    register_devices(@bus.devices)
    register_for_broadcast(@bus.simulated)
  end

  def name
    self.class.name
  end

  def update(action, properties)
    # LOGGER.unknown(name) { "#update(#{action}, #{properties})" }
    case action
    when PACKET_RECEIVED
      packet = fetch(properties, :packet)
      raise RoutingError, 'Packet is nil!' unless packet
      publish_to_bus(packet) if addressable?(packet)
    when BUS_ONLINE
      bus_online
    when BUS_OFFLINE
      LOGGER.warn(name) { BUS_OFFLINE }
      bus_offline
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |line| LOGGER.error(line) } 
  end

  def bus_online
    @bus.online
    @bus.simulated.send_all(:enable)
  end

  def bus_offline
    @bus.offline
    @bus.simulated.send_all(:disable)
  end

  def addressable?(packet)
    # LOGGER.warn(PACKET_RECEIVED) { packet }
    from_ident = packet.from
    has_from = bus_has_device?(from_ident)
    raise RoutingError, "#{from_ident} is not on the bus." unless has_from
    to_ident = packet.to
    has_to = bus_has_device?(to_ident)
    raise RoutingError, "#{to_ident} is not on the bus." unless has_to
    true
  end

  def publish_to_bus(packet)
    recipient = packet.to
    raise RoutingError, 'Recipient is nil!' unless recipient
    observers = subscribers[recipient]
    raise RoutingError, "No observers of #{recipient}" if observers.nil? || observers.empty?
    observers.each do |subscriber|
      subscriber.receive_packet(packet)
    end
  end

  def register_devices(devices)
    devices.each do |device|
      register_device(device.ident, device)
    end
  end

  def register_for_broadcast(devices)
    devices.each do |device|
      register_device(:glo_l, device)
      register_device(:glo_h, device)
    end
  end

  def register_device(to_ident, observer)
    subscribers(to_ident) << observer
  end

  private

  def bus_has_device?(device_ident)
    @bus.device?(device_ident)
  end


  def subscribers(ident = nil)
    # LOGGER.info(PROC) { "#subscribers(#{ident})" }
    if ident.nil?
      return_value = @subscribers ||= {}
      # LOGGER.info(PROC) { "#subscribers(nil) => #{return_value}" }
      return_value
    else
      var = subscribers
      if var.key?(ident)
        return_value = var[ident]
      else
        var[ident] = []
        return_value = var[ident]
      end

      # LOGGER.info(PROC) { "#subscribers(#{ident}) => #{return_value}" }
      return_value
    end
  end
end
