# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Device
      class Device
        include Constants
        include Observable

        CONNECTED = 'Connected'
        PAIRED = 'Paired'
        NAME = 'Name'
        ADDRESS = 'Address'
        KLASS = 'Class'
        UUIDS = 'UUIDs'
        TRUSTED = 'Trusted'
        BLOCKED = 'Blocked'
        ALIAS = 'Alias'
        ADAPTER = 'Adapter'
        ICON = 'Icon'

        attr_reader :attributes

        def initialize(attributes)
          @attributes = attributes
        end

        def pending
          @pending ||= false
        end

        def connecting
          @pending = true
          changed
          notify_observers(:connecting, device: self)
        end

        def disconnecting
          @pending = true
          changed
          notify_observers(:disconnecting, device: self)
        end

        def connected
          @pending = false
          changed
          notify_observers(:connected, device: self)
        end

        def disconnected
          @pending = false
          changed
          notify_observers(:disconnected, device: self)
        end

        def connected?
          attributes[CONNECTED]
        end

        def disconnected?
          !connected?
        end

        def paired?
          attributes[PAIRED]
        end

        def name
          attributes[NAME]
        end

        def address
          attributes[ADDRESS]
        end

        def klass
          attributes[KLASS]
        end

        def uuids
          attributes[UUIDS]
        end

        def trusted?
          attributes[TRUSTED]
        end

        def blocked?
          attributes[BLOCKED]
        end

        def alias
          attributes[ALIAS]
        end

        def adapter
          attributes[ADAPTER]
        end

        def icon
          attributes[ICON]
        end

        def attributes!(new_device)
          modified = []
          attributes.merge!(new_device.attributes) do |key, old, new|
            modified << key
            old.is_a?(Hash) ? squish(old, new) : new
          end
          changed
          notify_observers(:updated, changed: modified, device: self)
        end

        def squish(old, new)
          old.merge(new)
        end
      end
    end
  end
end
