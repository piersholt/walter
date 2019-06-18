# frozen_string_literal: true

module Wilhelm
  class Manager
    # Comment
    class Devices
      include Constants
      extend Forwardable
      include Observable

      FORWARD_MESSAGES = %i[<< push first last each empty? size sort_by length to_s count [] find_all find each_with_index find_index map group_by delete_at].freeze
      # SEARCH_PROPERTY = [:command_id, :from_id, :to_id].freeze

      FORWARD_MESSAGES.each do |method_name|
        def_delegator :devices, method_name
      end

      def device(object)
        return device_hash[object] if object.is_a?(String)
        return false unless include?(object)
        device_hash[object.address]
      end

      def device?(device_address)
        device_hash.key?(device_address)
      end

      def include?(device_object)
        device?(device_object.address)
      end

      def update_devices(devices_enum, event = nil)
        devices_enum.each do |a_device|
          update_device(a_device, event)
        end
      end

      def update_device(device_attributes_hash, event = nil)
        device_object = Device.new(device_attributes_hash)
        case include?(device_object)
        when true
          existing_device = device(device_object)
          existing_device.attributes!(device_object)
          existing_device.public_send(event) if event
          changed
          notify_observers(event || :updated, device: existing_device)
          existing_device
        when false
          new_device = add_device(device_object)
          new_device.public_send(event) if event
          changed
          notify_observers(event || :created, device: new_device)
          new_device
        end
      rescue StandardError => e
        logger.error(self.class) { e }
        with_backtrace(logger, e)
      end

      private

      def add_device(device_object)
        device_hash[device_object.address] = device_object
      end

      def devices
        device_hash.values
      end

      def device_hash
        @device_hash ||= {}
      end
    end
  end
end
