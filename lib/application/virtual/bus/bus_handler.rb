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
    register_tx_devices(@bus.dynamic)
    register_for_broadcast(@bus.simulated)
  end

  def name
    self.class.name
  end

  def update(action, properties)
    LOGGER.debug(name) { "#update(#{action}, #{properties})" }
    case action
    when MESSAGE_SENT
      message_sent(action, properties)
    when MESSAGE_RECEIVED
      message_received(action, properties)
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

  private

  # ------------------- MESSAGE_SENT -------------------------- #

  def message_sent(action, properties)
    LOGGER.debug(name) { "#message_sent" }
    message = fetch(properties, :message)
    raise RoutingError, 'Message is nil!' unless message
    add_to_output_buffer(message)
  rescue StandardError => e
    with_backtrace(LOGGER, e)
  end

  def add_to_output_buffer(message)
    result = @packet_output_buffer.push(message)
    LOGGER.debug(name) { "#add_to_output_buffer(#{message}) => #{result}" }
    result
  end

  # ------------------- PACKET_RECEIVED -------------------------- #

  def packet_received(action, properties)
    packet = fetch(properties, :packet)
    raise RoutingError, 'Packet is nil!' unless packet
    return false unless addressable?(packet)
    message = parse_packet(packet)
    changed
    notify_observers(MESSAGE_RECEIVED, message: message)
    # publish_to_bus(packet)
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

  def bus_has_device?(device_ident)
    @bus.device?(device_ident)
  end

  def parse_packet(packet)
    bus_message = Virtual::PacketWrapper.wrap(packet)

    from_ident = bus_message.from
    to_ident   = bus_message.to
    command    = bus_message.command
    args       = bus_message.arguments

    command_object = parse_command(from_ident, command.i, args)

    Virtual::Message.new(from_ident, to_ident, command_object)
  end

  def parse_command(from_ident, command, arguments)
    command_config = CommandMap.instance.config(command, from_ident)
    parameter_values_hash = parse_argumets(command_config, arguments)
    LOGGER.debug(self.class) { "Parameter Values: #{parameter_values_hash}" }
    command_object = build_command(command_config, parameter_values_hash)
    # LOGGER.info(ident) { command_object }
    command_object
  end

  private

  def parse_argumets(command_config, arguments)
    # LOGGER.info(ident) { "#parse_argumets" }
    if command_config.has_parameters? && !command_config.is_base?
      # LOGGER.info(ident) { "#{command_config.sn} has a klass and parameters. Will parse." }
       parse_indexed_arguments(command_config, arguments)
    else
      # LOGGER.info(ident) { "#{command_config.sn} is getting plain old arguments." }
      arguments
    end
  end

  def parse_indexed_arguments(command_config, arguments)
    parameter_values_hash = {}
    begin
      argument_index = command_config.index
      LOGGER.debug(self.class) { "argument index: #{argument_index}" }
      indexed_arguments = IndexedArguments.new(arguments, argument_index)
      LOGGER.debug(self.class) { "indexed_arguments: #{indexed_arguments}" }

      indexed_arguments.parameters.each do |name|
        param_value = indexed_arguments.lookup(name)
        LOGGER.debug(self.class) { "indexed_arguments.lookup(#{name}) => #{param_value ? param_value : 'NULL'}" }
        parameter_values_hash[name] = param_value
      end

      parameter_values_hash
    rescue StandardError => e
      LOGGER.error(self.class) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  def build_command(command_config, parameter_values_hash)
    LOGGER.debug(self.class) { "#build_command" }
    begin
      command_builder = command_config.builder
      command_builder = command_builder.new(command_config)
      command_builder.add_parameters(parameter_values_hash)

      command_builder.result
    rescue StandardError => e
      LOGGER.error(self.class) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  # ------------------- MESSAGE_RECEIVED -------------------------- #

  def message_received(action, properties)
    message = fetch(properties, :message)
    raise RoutingError, 'Message is nil!' unless message
    route_to_receivers(message)
    route_to_senders(message)
  end

  def route_to_receivers(packet)
    recipient = packet.to
    raise RoutingError, 'Recipient is nil!' unless recipient
    observers = subscribers[recipient]
    raise RoutingError, "No observers of #{recipient}" if observers.nil? || observers.empty?
    observers.each do |subscriber|
      # subscriber.receive_packet(packet)
      subscriber.virtual_receive(packet)
    end
  rescue RoutingError
    # packet.instance_variable_set(:@from, :dia)
    # @bus.dia.receive_packet(packet)
    # @bus.dia.receive_message(packet)
    false
  end

  def route_to_senders(packet)
    sender = packet.from
    raise RoutingError, 'Recipient is nil!' unless sender
    observers = publishers[sender]
    raise RoutingError, "No observers of #{sender}" if observers.nil? || observers.empty?
    observers.each do |publisher|
      # publisher.publish_packet(packet)
      publisher.virtual_transmit(packet)
    end
  rescue RoutingError
    false
  end

  # ------------------- BUS_ONLINE -------------------------- #

  def bus_online
    LOGGER.info(name) { 'Bus Offline! Disabling virtual bus.' }
    @bus.online
    @bus.simulated.send_all(:enable)
  end

  # ------------------- BUS_OFFLINE -------------------------- #

  def bus_offline
    LOGGER.warn(name) { 'Bus Offline! Disabling virtual bus.' }
    @bus.offline
    @bus.simulated.send_all(:disable)
  end

  # ------------------- initialize -------------------------- #

  def register_devices(devices)
    devices.each do |device|
      register_device(device.ident, device)
    end
  end

  def register_device(to_ident, observer)
    subscribers(to_ident) << observer
  end

  def register_tx_devices(devices)
    devices.each do |device|
      register_tx_device(device.ident, device)
    end
  end

  def register_tx_device(to_ident, observer)
    publishers(to_ident) << observer
  end

  def register_for_broadcast(devices)
    devices.each do |device|
      register_device(:glo_l, device)
      register_device(:glo_h, device)
    end
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

  def publishers(ident = nil)
    # LOGGER.info(PROC) { "#publishers(#{ident})" }
    if ident.nil?
      return_value = @publishers ||= {}
      # LOGGER.info(PROC) { "#publishers(nil) => #{return_value}" }
      return_value
    else
      var = publishers
      if var.key?(ident)
        return_value = var[ident]
      else
        var[ident] = []
        return_value = var[ident]
      end

      # LOGGER.info(PROC) { "#publishers(#{ident}) => #{return_value}" }
      return_value
    end
  end
end
