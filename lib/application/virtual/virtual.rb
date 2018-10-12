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

    def initialize
      @devices = []
    end

    def include?(device_ident)
      @devices.one? do |device|
        device.ident == device_ident
      end
    end

    def add(device)
      @devices << device
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

  class Bus
    include Singleton
    attr_reader :devices

    def initialize
      @devices = Devices.new
    end

    def device?(device_ident)
      @devices.include?(device_ident)
    end

    def add_device(device)
      @devices.add(device)
    end

    def all(method, *arguments)
      @devices.each do |device|
        # LOGGER.warn(device)
        # LOGGER.warn(method)
        # LOGGER.warn(arguments)
        device.public_send(method, *arguments)
      end
    end
  end

  class Initialization
    PROC = 'Initialization'
    def initialize
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
        Device.new(device_ident)
      end

      LOGGER.debug(PROC) { "Devices: #{devices}|" }
      devices
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
