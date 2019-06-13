class Wilhelm::Virtual
  class Bus
    include Singleton
    extend Forwardable
    include Wilhelm::Helpers::NameTools

    attr_reader :devices

    def_delegators :@devices, :send_all, :dynamic, :augmented, :simulated, :broadcast, :dumb

    def initialize
      @devices = Devices.new
      @status = :down
    end

    def inspect
      "#<Virtual::Bus:0x00>"
    end

    def online
      @status = :up
    end

    def offline
      @status = :down
    end

    def up?
      case @status
      when nil
        false
      when :up
        true
      when :down
        false
      end
    end

    def down?
      case @status
      when nil
        false
      when :up
        false
      when :down
        true
      end
    end

    def device?(device_ident)
      @devices.include?(device_ident)
    end

    def add_device(device)
      @devices.add(device)
      setup_accessor(device)
    end

    def setup_accessor(device)
      ident = device.ident
      instance_variable_name = inst_var(ident)
      instance_variable_set(instance_variable_name, device)
      Bus.class_exec(ident) { |i| attr_reader i }
    end
  end
end
