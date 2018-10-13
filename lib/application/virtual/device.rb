class Virtual
  class Device
    include Observable
    include Receivable

    PROC = 'Device'.freeze

    attr_reader :ident

    def initialize(device_ident)
      @ident = device_ident
    end

    def i_am(other)
      ident == other
    end

    def type
      :dumb
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

  class BroadcastDevice < Device
    PROC = 'BroadcastDevice'.freeze

    def type
      :broadcast
    end
  end

  class SimulatedDeviceBuilder
    include ModuleTools

    CLASS_MAP = {
      dsp: 'SimulatedDSP'
    }.freeze

    attr_reader :ident

    def simulate(ident)
      raise StandardError, "no class to simulate #{ident}" unless CLASS_MAP.key?(ident)
      @ident = ident
      self
    end

    def result
      raise StandardError, "no ident set!" unless @ident
      klass_constant = CLASS_MAP[ident]
      klass_constant = prepend_namespace('Virtual', klass_constant)
      klass = get_class(klass_constant)
      klass.new(ident)
    end
  end

  require 'application/virtual/ping_pong'

  class SimulatedDevice < Device
    include CommandTools

    PING = 0x01
    IGNITION = 0x11

    include PingPong

    PROC = 'SimulatedDevice'.freeze

    def self.builder
      SimulatedDeviceBuilder.new
    end

    def initialize(args)
      super(args)
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

    # @override Virtual::Device#receive_packet
    def receive_packet(packet)
      message = super(packet)
      handle_message(message)
    end
  end

  class SimulatedDSP < SimulatedDevice
    PROC = 'SimulatedDSP'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when PING
        respond
      when IGNITION
        announce?(message.command)
      end
    end
  end
end
