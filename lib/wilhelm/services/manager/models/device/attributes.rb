# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class Device
        # Manager::Device::Attributes
        module Attributes
          include Constants

          attr_reader :attributes

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
            attributes.merge!(new_device.attributes) do |_, old, new|
              old.is_a?(Hash) ? squish(old, new) : new
            end
            # changed
            # notify_observers(:updated, device: self)
          end

          def squish(old, new)
            old.merge(new)
          end
        end
      end
    end
  end
end
