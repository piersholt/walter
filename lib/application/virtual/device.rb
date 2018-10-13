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
      dsp: 'SimulatedDSP',
      cdc: 'SimulatedCDC'
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
  require 'application/virtual/cd'

  class SimulatedDevice < Device
    include CommandTools

    DEFAULT_STATUS = :down

    PING = 0x01
    IGNITION = 0x11

    include PingPong

    PROC = 'SimulatedDevice'.freeze

    def self.builder
      SimulatedDeviceBuilder.new
    end

    def initialize(args)
      super(args)
      @status = DEFAULT_STATUS
    end

    def type
      :simulated
    end

    def enable
      @status = :up
    end

    def disable
      @status = :down
    end

    def enabled?
      case @status
      when nil
        false
      when :up
        true
      when :down
        false
      end
    end

    def disabled?
      case @status
      when nil
        false
      when :up
        false
      when :down
        true
      end
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
      handle_message(message) if enabled?
    end

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when PING
        respond
      end
    end

    def alt
      @alt ||= AddressLookupTable.instance
    end

    def address(ident)
      alt.get_address(ident)
    end

    def my_address
      alt.get_address(ident)
    end
  end

  class SimulatedDSP < SimulatedDevice
    PROC = 'SimulatedDSP'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when IGNITION
      end

      super(message)
    end
  end

  class SimulatedCDC < SimulatedDevice
    include CD

    PROC = 'SimulatedDSP'.freeze

    CHANGER_REQUEST = 0x38

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when CHANGER_REQUEST
        handle_changer_request(message)
      end

      super(message)
    end
  end
end
