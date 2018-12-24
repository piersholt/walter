class RoutingError < StandardError
  def message
    "A routing error has occured!"
  end
end

class BusHandler < BaseHandler
  include LogActually::ErrorOutput
  PROC = 'BusHandler'.freeze

  def initialize(bus:, packet_output_buffer:)
    @bus = bus
    @packet_output_buffer = packet_output_buffer
    register_devices(@bus.devices)
    register_for_broadcast(@bus.simulated)
  end

  def name
    self.class.name
  end

  def message_sent(action, properties)
    LOGGER.debug(name) { "#message_sent" }
    message = fetch(properties, :message)
    raise RoutingError, 'Message is nil!' unless message
    add_to_output_buffer(message)
  rescue StandardError => e
    with_backtrace(LOGGER, e)
  end

  def packet_received(action, properties)
    packet = fetch(properties, :packet)
    raise RoutingError, 'Packet is nil!' unless packet
    publish_to_bus(packet) if addressable?(packet)
  end

  def update(action, properties)
    LOGGER.debug(name) { "#update(#{action}, #{properties})" }
    case action
    when MESSAGE_SENT
      message_sent(action, properties)
    when PACKET_RECEIVED
      packet_received(action, properties)
    when BUS_ONLINE
      bus_online
    when BUS_OFFLINE
      bus_offline
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |line| LOGGER.error(line) }
  end

  def bus_online
    LOGGER.info(name) { 'Bus Offline! Disabling virtual bus.' }
    @bus.online
    @bus.simulated.send_all(:enable)
  end

  def bus_offline
    LOGGER.warn(name) { 'Bus Offline! Disabling virtual bus.' }
    @bus.offline
    @bus.simulated.send_all(:disable)
  end

  def addressable?(packet)
    from_ident = packet.from
    has_from = bus_has_device?(from_ident)
    raise RoutingError, "#{from_ident} is not on the bus." unless has_from
    to_ident = packet.to
    has_to = bus_has_device?(to_ident)
    raise RoutingError, "#{to_ident} is not on the bus." unless has_to
    true
  rescue RoutingError
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
  rescue RoutingError
    packet.instance_variable_set(:@from, :dia)
    @bus.dia.receive_packet(packet)
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

  def add_to_output_buffer(message)
    result = @packet_output_buffer.push(message)
    LOGGER.debug(name) { "#add_to_output_buffer(#{message}) => #{result}" }
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
