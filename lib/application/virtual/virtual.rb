# frozen_string_literal: true

class Virtual
  class Message
    attr_accessor :from, :to, :command

    alias :receiver :to
    alias :sender :from

    def initialize(from, to, command)
      @from = from
      @to = to
      @command = command
    end

    def to_s
      begin
        return inspect if command.verbose
        "#{from}\t#{to}\t#{command}"
      rescue StandardError => e
        LOGGER.error(PROC) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(PROC) { l } }
        binding.pry
      end
    end

    def inspect
      "#{from}\t#{to}\t#{command.inspect}"
    end
  end

  module Receivable
    include Event
    def receive_packet(packet)
      bus_message = PacketWrapper.wrap(packet)

      from_ident = bus_message.from
      to_ident   = bus_message.to
      command    = bus_message.command
      args       = bus_message.arguments

      command_object = parse_command(from_ident, command.i, args)

      message = Message.new(from_ident, to_ident, command_object)
      changed
      notify_observers(MESSAGE_RECEIVED, message: message)
    end

    def parse_command(from, command, arguments)
      command_config = CommandMap.instance.config(command)
      parameter_values_hash = parse_argumets(command_config, arguments)
      LOGGER.debug(ident) { "Parameter Values: #{parameter_values_hash}" }
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
        LOGGER.debug(ident) { "argument index: #{argument_index}" }
        indexed_arguments = IndexedArguments.new(arguments, argument_index)
        LOGGER.debug(ident) { "indexed_arguments: #{indexed_arguments}" }

        indexed_arguments.parameters.each do |name|
          param_value = indexed_arguments.lookup(name)
          LOGGER.debug(ident) { "indexed_arguments.lookup(#{name}) => #{param_value ? param_value : 'NULL'}" }
          parameter_values_hash[name] = param_value
        end

        parameter_values_hash
      rescue StandardError => e
        LOGGER.error(ident) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end

    def build_command(command_config, parameter_values_hash)
      LOGGER.debug(ident) { "#build_command" }
      begin
        command_builder = command_config.builder
        command_builder = command_builder.new(command_config)
        command_builder.add_parameters(parameter_values_hash)

        command_builder.result
      rescue StandardError => e
        LOGGER.error(ident) { "#{e}" }
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end
  end

  class Devices
    extend Forwardable

    array_methods = Array.instance_methods(false)
    array_methods = array_methods + Enumerable.instance_methods(false)
    array_methods.each do |fwrd_message|
      def_delegator :@devices, fwrd_message
    end

    def initialize(devices = [])
      @devices = devices
    end

    def send_all(method, *arguments)
      @devices.each do |device|
        device.public_send(method, *arguments)
      end
    end

    def include?(device_ident)
      @devices.one? do |device|
        device.ident == device_ident
      end
    end

    def add(device)
      @devices << device
    end

    def list
      @devices.map(&:ident)
    end
  end

  class PacketWrapper
    extend Forwardable

    def_delegators :@packet, :to, :from, :data

    def self.wrap(packet)
      PacketWrapper.new(packet)
    end

    def initialize(packet)
      @packet = packet
    end

    def command
      data = @packet.data
      data[0]
    end

    def arguments
      data = @packet.data
      data[1..-1]
    end

    def to_s
      "#{from} >\t[#{command}]\t#{arguments}"
    end
  end

  class Device
    include Observable
    include Receivable

    PROC = 'Device'.freeze

    attr_reader :ident

    def initialize(device_ident)
      @ident = device_ident
    end

    # @override Object#inspect
    def inspect
      "#<Device :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end
  end

  module BaseSimulate
    include API::Alive

    PROC = 'BaseSimulate'.freeze

    def check_message(message)
      command_id = message.command.d
      case command_id
      when 0x01
        respond
      when 0x11
        announce?(message.command)
      end
    end

    def already_announced?
      if @already_announced.nil? || @already_announced == false
        false
      else
        true
      end
    end

    def announced!
      @already_announced = true
    end

    def announce?(ignition)
      return false if already_announced?
      announce if ignition.accessory?
    end

    def announce
      announced!
      LOGGER.warn(ident) { "HEY EVERYONE! COME SEE HOW GOOD #{@ident} looks!" }

      alt = AddressLookupTable.instance
      from_id = alt.get_address(ident)
      to_id = alt.get_address(:glo_h)

      # LOGGER.warn(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

      pong({status: 0x01}, from_id, to_id)
    end

    def respond
      LOGGER.warn(PROC) { "So, I #{@ident} had best simulateth a pongeth!" }

      alt = AddressLookupTable.instance
      from_id = alt.get_address(ident)
      to_id = alt.get_address(:glo_l)

      # LOGGER.warn(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

      pong({status: 0x00}, from_id, to_id)
    end
  end

  class SimulatedDevice < Device
    include BaseSimulate

    PROC = 'SimulatedDevice'.freeze

    def initialize(args)
      super(args)

      # announce
    end

    def type
      :simulated
    end

    # @override Object#inspect
    def inspect
      "#<SimulatedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end

    def receive_packet(packet)
      message = super(packet)

      check_message(message)
    end
  end

  class Bus
    include Singleton
    attr_reader :devices

    def initialize
      @devices = Devices.new
      @status = :down
    end

    def online
      @status = :up
    end

    def offline
      @status = :down
    end

    def device?(device_ident)
      @devices.include?(device_ident)
    end

    def add_device(device)
      @devices.add(device)
    end
  end

  class Initialization
    PROC = 'Initialization'
    def initialize(opts = { simulated: [] })
      @simulated = opts[:simulated]
      @executed = false
    end

    def execute
      bus = create_bus
      device_idents = lookup_devices
      devices = create_devices(device_idents)
      populate_bus(bus, devices)
      bus
    end

    def create_bus
      Bus.instance
    end

    def lookup_devices
      alt = AddressLookupTable.instance
      idents = alt.idents
      LOGGER.debug(PROC) { "Idents: #{idents}|" }
      idents
    end

    def create_devices(device_idents)
      devices = device_idents.map do |device_ident|
        create_device(device_ident)
      end

      LOGGER.debug(PROC) { "Devices: #{devices}|" }
      devices
    end

    def create_device(device_ident)
      if @simulated.include?(device_ident)
        SimulatedDevice.new(device_ident)
      else
        Device.new(device_ident)
      end
    end

    def populate_bus(bus, devices)
      devices.each do |device|
        bus.add_device(device)
      end

      LOGGER.debug(PROC) { "Bus Devices: #{bus.devices}" }
      true
    end
  end
end
