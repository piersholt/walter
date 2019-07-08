# frozen_string_literal: false

module Wilhelm
  module Virtual
    # Virtual::Devices Data Structure
    class Devices
      extend Forwardable

      attr_reader :devices

      array_methods = Array.instance_methods(false)
      array_methods += Enumerable.instance_methods(false)
      array_methods.each do |fwrd_message|
        def_delegator :devices, fwrd_message
      end

      def initialize(devices = [])
        @devices = devices
      end

      def send_all(method, *arguments)
        devices.each do |device|
          device.public_send(method, *arguments)
        end
      end

      def include?(device_ident)
        devices.one? do |device|
          device.ident == device_ident
        end
      end

      def add(device)
        devices << device
      end

      def list
        devices.map(&:ident)
      end

      def base
        base_devices = devices.find_all do |d|
          d.type == TYPE_BASE
        end
        Devices.new(base_devices)
      end

      def dynamic
        dynamic_devices = devices.find_all do |d|
          TYPE_DYNAMIC.any? { |t| t == d.type }
        end
        Devices.new(dynamic_devices)
      end

      def augmented
        augmented_devices = devices.find_all do |d|
          d.type == TYPE_AUGMENTED
        end
        Devices.new(augmented_devices)
      end

      def emulated
        emulated_devices = devices.find_all do |d|
          d.type == TYPE_EMULATED
        end
        Devices.new(emulated_devices)
      end

      alias simulated emulated

      def broadcast
        broadcast_devices = devices.find_all do |d|
          d.type == TYPE_BROADCAST
        end
        Devices.new(broadcast_devices)
      end
    end
  end
end
