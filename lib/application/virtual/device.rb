class Virtual
  class Device
    include Observable
    include Receivable

    PROC = 'Device'.freeze

    attr_reader :ident

    alias_method :me, :ident

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

  # ----------------- DYNAMIC DEVICES ----------------- #

  class DynamicDeviceBuilder
    include ModuleTools

    CLASS_MAP = {
      dsp: 'SimulatedDSP',
      cdc: 'SimulatedCDC',
      tel: 'SimulatedTEL',
      rad: 'AugmentedRAD'
    }.freeze

    attr_reader :ident

    def target(ident)
      raise StandardError, "no class to target #{ident}" unless CLASS_MAP.key?(ident)
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

  class DynamicDevice < Device
    include CommandAliases

    DEFAULT_STATUS = :up

    def self.builder
      DynamicDeviceBuilder.new
    end

    def initialize(args)
      super(args)
      @status = DEFAULT_STATUS
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

    def alt
      @alt ||= AddressLookupTable.instance
    end

    def address(ident)
      alt.get_address(ident)
    end

    def my_address
      alt.get_address(ident)
    end

    # @override Virtual::Device#receive_packet
    # Allows the introduction of custom behaviour
    def receive_packet(packet)
      message = super(packet)
      handle_message(message) if enabled?
    end
  end

  # ----------------- SIMULATED DEVICES ----------------- #

  require 'application/virtual/stateful'
  require 'application/virtual/alive'
  require 'application/virtual/cd'
  require 'application/virtual/telephone'

  class SimulatedDevice < DynamicDevice
    include Alive

    PROC = 'SimulatedDevice'.freeze

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

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when PING
        respond
      end
    end
  end

  class SimulatedDSP < SimulatedDevice
    PROC = 'SimulatedDSP'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when DSP_EQ
        true
      end

      super(message)
    end
  end

  class SimulatedCDC < SimulatedDevice
    include CD

    PROC = 'SimulatedDSP'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when CHANGER_REQUEST
        handle_changer_request(message)
      end

      super(message)
    end
  end

  class SimulatedTEL < SimulatedDevice
    include Telephone

    PROC = 'SimulatedTEL'.freeze

    def handle_message(message)
      command_id = message.command.d
      LOGGER.debug('SimulatedTEL!') { "handle message id: #{command_id}" }
      case command_id
      when PONG
        LOGGER.debug('SimulatedTEL!') { "handling pong" }
        handle_announce(message)
      when GFX_STATUS
        handle_gfx_status(message)
      when TEL_DATA
        handle_data_request(message)
      when TEL_OPEN
        handle_tel_open(message)
      end

      super(message)
    end
  end

  # ----------------- AUGMENTED DEVICES ----------------- #

  class AugmentedDevice < DynamicDevice
    include Actions

    PROC = 'AugmentedDevice'.freeze

    def initialize(args)
      super(args)
    end

    def type
      :augmented
    end

    # @override Object#inspect
    def inspect
      "#<AugmentedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end
  end

  class AugmentedRAD < AugmentedDevice
    include API::Media
    PROC = 'AugmentedRAD'.freeze

    def track_change(track)
      return false if @thread
      @thread = Thread.new(track) do |t|
        begin
          LOGGER.fatal(self.class) { t }
          title = t['Title']
          artist = t['Artist']
          scroll = "#{title} / #{artist}"

          displays( { chars: '', gfx: 0xC4, ike: 0x20,}, my_address, address(:ike) )

          i = 0
          last = scroll.length

          while i <= last do
            scroll = scroll.bytes.rotate(i).map { |i| i.chr }.join
            displays( { chars: scroll, gfx: 0xC4, ike: 0x30,}, my_address, address(:ike) )
            sleep(2)
            i += 1
          end
        rescue StandardError => e
          LOGGER.error(self.class) { e }
        end
      end
      @thread = nil
      true
    end

    def handle_message(message)
      # LOGGER.warn(PROC) { 'i am a trying to handle this hokay!' }
      command_id = message.command.d
      case command_id
      when MFL_FUNC
        seek = [0x01, 0x11, 0x21, 0x08, 0x18, 0x28]

        seek_next = [0x01, 0x11, 0x21]
        seek_previous = [0x08, 0x18, 0x28]

        button_press = [0x01, 0x08]
        button_hold = [0x11, 0x18]
        button_release = [0x21, 0x28]

        value = message.command.totally_unique_variable_name

        if seek.any? { |x| x == value }
          if seek_next.any? { |x| x == value }
            variant = NEXT
          elsif seek_previous.any? { |x| x == value }
            variant = PREVIOUS
          end

          if button_press.any? { |x| x == value }
            state = PRESS
          elsif button_hold.any? { |x| x == value }
            state = HOLD
          elsif button_release.any? { |x| x == value }
            state = RELEASE
          end

          changed(true)
          notify_observers(SEEK, variant: variant, control: BUTTON, state: state)
        end
      when MFL_VOL
        # changed(true)
        # notify_observers(SEEK)
        true
      end
    end
  end
end
