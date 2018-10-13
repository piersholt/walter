class Virtual
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

    def dumb
      dumb_devices = @devices.find_all  {|d| d.type == :dumb }
      Devices.new(dumb_devices)
    end

    def simulated
      simulated_devices = @devices.find_all  {|d| d.type == :simulated }
      Devices.new(simulated_devices)
    end

    def broadcast
      broadcast_devices = @devices.find_all  {|d| d.type == :broadcast }
      Devices.new(broadcast_devices)
    end
  end
end
